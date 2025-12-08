# Releasing mParticle Apple Media SDK

This document describes the automated release process for the mParticle Apple Media SDK.

## Overview

The release process is automated through two GitHub Actions workflows:

1. **Create Release PR** (`.github/workflows/draft-release-publish.yml`) - Creates a pull request with the version bump
2. **Publish Release** (`.github/workflows/release-from-main.yml`) - Automatically publishes the release when the PR is merged

## Release Process

### Step 1: Create a Release PR

1. Go to the **Actions** tab in GitHub
2. Select the **"Create draft release"** workflow from the left sidebar
3. Click the **"Run workflow"** dropdown button
4. Select the version bump type:
   - **patch**: Bug fixes and minor updates (e.g., 1.6.0 → 1.6.1)
   - **minor**: New features that are backwards compatible (e.g., 1.6.0 → 1.7.0)
   - **major**: Breaking changes (e.g., 1.6.0 → 2.0.0)
5. Click **"Run workflow"**

The workflow will:
- Read the current version from `mParticle-Apple-Media-SDK.podspec`
- Bump the version according to your selection
- Update the podspec file with the new version
- Create a pull request to `main` with the branch name `release/{new_version}`

### Step 2: Review the Pull Request

1. The workflow will create a PR titled **"Release {version}"**
2. Review the changes in the PR:
   - Verify the version number is correct in the podspec
   - Ensure the bump type matches what you intended
   - Ensure all of the workflows succeed 
3. Request reviews from other maintainers if needed
4. Add any release notes or changelog entries to the PR description if desired

### Step 3: Merge the Pull Request

Once the PR is approved and ready to release:

1. Merge the pull request to `main` (using any merge method)
2. The **"Release SDK"** workflow will **automatically trigger** because the podspec file was modified on main

### Step 4: Automatic Publishing

The publish workflow will automatically:

1. Extract the version number from the updated podspec
2. Create a git tag with the version number (e.g., `1.7.0`)
3. Push the tag to GitHub
4. Publish the pod to CocoaPods trunk using `pod trunk push --allow-warnings`