fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
### branch_finish
```
fastlane branch_finish
```
Push branch and creates a Pull Request
### release_start
```
fastlane release_start
```
Creates a release branch with the pubspec.yaml version and push it to remote branch
### release_finish
```
fastlane release_finish
```
push the release branch to remote repo and open PR

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
