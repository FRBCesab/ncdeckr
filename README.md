
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ncdeckr <img src="man/figures/package-sticker.png" align="right" style="float:right; height:120px;"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/ncdeckr)](https://CRAN.R-project.org/package=ncdeckr)
[![R CMD
Check](https://github.com/frbcesab/ncdeckr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/frbcesab/ncdeckr/actions/workflows/R-CMD-check.yaml)
[![Website](https://github.com/frbcesab/ncdeckr/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/frbcesab/ncdeckr/actions/workflows/pkgdown.yaml)
![Code Coverage:
69%](https://img.shields.io/badge/Code%20coverage-69%25-e05d44)
[![License: GPL (\>=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
<!-- badges: end -->

<p align="left">

• <a href="#overview">Overview</a><br> •
<a href="#features">Features</a><br> •
<a href="#installation">Installation</a><br> •
<a href="#get-started">Get started</a><br> •
<a href="#long-form-documentations">Long-form documentations</a><br> •
<a href="#code-coverage">Code coverage</a><br> •
<a href="#citation">Citation</a><br> •
<a href="#contributing">Contributing</a><br> •
<a href="#acknowledgments">Acknowledgments</a><br> •
<a href="#references">References</a>
</p>

## Overview

[Nextcloud Deck](https://apps.nextcloud.com/apps/deck) is a kanban style
organization tool aimed at personal planning and project organization
for teams integrated with Nextcloud.

![](man/figures/README-image.png)

The R package `ncdeckr` is a client to the [Nextcloud Deck
API](https://deck.readthedocs.io/en/latest/API/). It is dedicated to
manage (list, create, delete, update) boards, stacks, cards and labels.

`ncdeckr` is freely released by the
[FRB-CESAB](https://www.fondationbiodiversite.fr/en/about-the-foundation/le-cesab/).

## Requirements

To use `ncdeckr`, you need to locally store your Nextcloud credentials:

- the URL of the Nextcloud server
- your username on the Nextcloud instance
- an application password

To generate a Nextcloud application password, go to the Settings and
open the Security menu. At the bottom, generate a new app password (use
`ncdeckr` as the app name).

Once your password is created, store your Nextcloud credentials on your
computer. A good practice in [managing
secrets](https://cran.r-project.org/web/packages/httr/vignettes/secrets.html)
is to store this information as R Environment variables.

Use the function `usethis::edit_r_environ()` to open the `~/.Renviron`
file and add these three lines:

    NEXTCLOUD_USERNAME='your-username'
    NEXTCLOUD_PASSWORD='your-password'
    NEXTCLOUD_SERVER='https://...'

Save this file and restart R.

## Features

Coming soon…

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
## Install < remotes > package (if not already installed) ----
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## Install < ncdeckr > from GitHub ----
remotes::install_github("frbcesab/ncdeckr")
```

Then you can attach the package `ncdeckr`:

``` r
library("ncdeckr")
```

## Get started

For an overview of the main features of `ncdeckr`, please read the [Get
started](https://frbcesab.github.io/ncdeckr/articles/ncdeckr.html)
vignette.

<!--
&#10;## Long-form documentations
&#10;`ncdeckr` provides **{{ NUMBER OF VIGNETTES }}** vignettes to learn more about the package:
&#10;- the [Get started](https://frbcesab.github.io/ncdeckr/articles/ncdeckr.html)
vignette describes the core features of the package
- **{{ LIST ADDITIONAL VIGNETTES }}**
&#10;-->

## Code coverage

<details>

<summary>
Click to expand results
</summary>

| File | Coverage |  |
|:---|---:|:---|
| `R/nc_list_stacks.R` | 0.00% | <svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:1em;width:1em;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#e05d44;overflow:visible;position:relative;"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z"/></svg> |
| `R/utils.R` | 84.00% | <svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:1em;width:1em;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#dfb317;overflow:visible;position:relative;"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z"/></svg> |
| `R/nc_list_boards.R` | 100.00% | <svg aria-hidden="true" role="img" viewBox="0 0 512 512" style="height:1em;width:1em;vertical-align:-0.125em;margin-left:auto;margin-right:auto;font-size:inherit;fill:#44cc11;overflow:visible;position:relative;"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z"/></svg> |

<small>*Last update:* 2026-02-07</small>

</details>

## Citation

Please cite `ncdeckr` as:

> Casajus Nicolas (2026) ncdeckr: An R Client to the Nextcloud Deck API.
> R package version 0.0.0.9000. <https://github.com/frbcesab/ncdeckr/>

## Contributing

All types of contributions are encouraged and valued. For more
information, check out our [Contributor
Guidelines](https://github.com/frbcesab/ncdeckr/blob/main/CONTRIBUTING.md).

Please note that the `ncdeckr` project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
