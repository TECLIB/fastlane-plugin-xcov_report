#!/bin/bash

GITHUB_COMMIT_MESSAGE=$(git log --format=oneline -n 1 ${CIRCLE_SHA1})

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* ]]; then

    # Generate CHANGELOG.md and increment version
    IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$CIRCLE_BRANCH" )";

    if [[ $CIRCLE_BRANCH != "$IS_PRERELEASE" ]]; then
        PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
        npm run release -- -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"
    else
        npm run release -- -m "ci(release): generate CHANGELOG.md for version %s"
    fi

    # Get version number from package.json
    export GIT_TAG=$(jq -r ".version" package.json)
    # Copy CHANGELOG.md to gh-pages branch
    npm run gh-pages-changelog -- -m "ci(docs): generate CHANGELOG.md for version ${GIT_TAG}"
    # Push commits and tags to origin branch
    git push --follow-tags origin $CIRCLE_BRANCH
    # Create release with conventional-github-releaser
    npm run conventional-github-releaser -- -p angular -t $GITHUB_TOKEN

    # Update develop branch
    git fetch origin develop
    git checkout develop
    git clean -d -x -f
    git merge $CIRCLE_BRANCH
    git push origin develop

    # Update master branch
    git fetch origin master
    git checkout master
    git clean -d -x -f
    git merge $CIRCLE_BRANCH
    git push origin master

    # Remove release branch
    git push origin :$CIRCLE_BRANCH
fi
