# `aws-okta` for Windows
This repository contains build automation for [aws-okta](https://github.com/segmentio/aws-okta), to produce native Windows binaries and MSI installers.

This is not a fork of aws-okta.

The binaries released here are built from the source in the original repository without modification.

---

## Building Locally
### Requirements
None of the steps in this process are run in Windows itself. Tested in Ubuntu.

* `bash` (other shells probably work, not tested)
* `make`, `git`
* To detect the latest released version automatically, you also need `curl` and `basename`.
* **GoLang version 1.13 or later.**
* To build the installer you need `docker`.
### Steps
1. Clone the repository
1. ```bash
   cd build
   ```
1. For the binary only:

   ```bash
   make build
   ```

   For the binary and installer:

   ```bash
   make installer
   ```

The executable will be in `installer/src/bin/` and the installer will be in `installer/out/`.

---

## GitHub Actions Workflow
See: https://github.com/flatironhealth/aws-okta-windows/blob/main/.github/workflows/build.yml

The workflow builds both the executable and an installer package and publishes it in a GitHub release.

The workflow can be initiated manually (workflow dispatch) but also runs on a set schedule looking for the latest release on the `aws-okta` project and running against that if there's no existing release.

The manual run takes an optional version tag on the source repo to build against. If none is specified it works the same as the scheduled run, in that it looks for the latest release.

In all runs, if an existing release exists in _this_ repository, the build and release publishing are skipped.

To remove and re-publish a release, you need to remove both the release _and_ the git tag associated with it.

The release can be deleted on GitHub (open the individual release, click `Delete`), but the tag cannot. To delete the tag, you need push rights. Clone the repo locally, run the following (`v1.99.99` for this example):
```bash
git tag --delete v1.99.99
git push --delete origin v1.99.99
```

## Notes
* Our release tags match those of the `aws-okta` project, but because our tags all point to the tip of `main` at the time of publish, they don't actually point to anything meaningful.
* If an earlier version than the latest is published after a newer version, GitHub will feature it as the "latest" release, which is a bit confusing. While it may be annoying, in that case it's probably best to delete all the existing releases and republish in order, just for visual consistency.
* GitHub automatically releases archives of the source code with published releases, and it can't be turned off. Since we aren't a fork, that source would be misleading. So `.gitattributes` is set to exclude everything from the archive, which means the archives published are actually empty.
