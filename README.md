
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jecfa

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

The goal of `{jecfa}` is to implement a pipeline to download and process
JECFA monographs, offering a Docker image to run the pipeline in
isolation and independently from OS or installed dependencies.

# Overview

The project is orchestrated by the `targets` package, which is a
pipeline toolkit for R.(Landau 2024) The pipeline is defined in
`_targets.R` and the main functions are in `R/` folder.

Main folders of the project are:

- `dev/`: contains the development scripts and files, i.e., the
  requirements, the script so execute the pipeline interactively and in
  background (on RStudio), and a checklist to run the pipeline.

- `R/`: contains the main functions of the project (in RStudio you can
  access function definition directly on the correct file by pressing
  `F2` on the function name wherever it is used in the project), and you
  can also access the documentation of the function by pressing `F1` on
  the function name (or standard `?<function_name>` in the console).

- `data/`: contains the data saved/downloaded/used in the project, i.e.:

  - `FAS/`: contains the FAS PDFs (provided externally)
  - `TRS/`: contains the TRS PDFs (downloaded by the pipeline)
  - `TRS_unique/`: contains the TRS PDFs without the ID
  - `used/`: contains the data used in the tm phase

- `output/`: contains the output of the pipeline, i.e., the tables and
  the figures, and the shared object defined in the pipeline

- `report/`: contains the reports and exploratory scripts of the
  pipeline, i.e., the Rmd files and the corresponding rendered HTMLs.

After the first run of the pipeline, you can access to every object
defined in the pipeline by running `tar_read(<unquoted_target_name>)` in
the R console (even in new session within the project). E.g., you can
always retrieve the final `jecfaDistiller` dataset by running

``` r
library(targets)
tar_read(jecfaDistiller)
```

Next, every time you run the pipeline, the pipeline will only re-run the
necessary steps to update the targets defined in the pipeline script
`_targets.R` as `tar_target(...)`.

If you like to see the state of the pipeline, you can run
`tar_visnetwork()` to see the pipeline as a network graph. Note that
`tar_visnetwork()` will show all the functions and dependencies of the
pipeline, so it could be a bit overwhelming, we suggest to call the
`tar_visnetwork(targets_only = TRUE)` to see only the targets (i.e., the
objects) of the pipeline.

# Execution

To run the pipeline, you would need an RStudio and open the project in
it (this is not strongly required, but we assume it, and we do not
discuss/document alternatives).

To do that we provide two main ways: use your local RStudio environment,
or an RStudio server within a provided and configured Docker container.

> NOTE: the system is not designed to run by the user directly. So, try
> to execute pieces of the pipeline interactively will lead to errors.
> To explore objects, and use the functions provided, you can use the
> `report/explore.R` script/template.

## Docker

The easiest way to activate/use the project and run the pipeline is to
use Docker. To do that, you would need to have Docker installed in your
machine. If you do not have Docker installed, you can follow the
instructions on the [Docker
website](https://docs.docker.com/get-docker/).

Next, download the file `docker-compose.yaml` into any folder of your
host machine / computer, be sure Docker engine in running, go to a
terminal window (on Windows use CMD, we did not tested the execution on
PS), and run:

``` bash
docker-compose up --build --detach
```

to start the container. Next you can visit in any browser of your host
machine the address `localhost:18787` to access the RStudio Server with
all the dependencies installed and ready to work. The username is
`rstudio`, and password is `jecfa`. Once inside RStudio server, enter
the `jecfa/` folder (the only one you see there) and click and activate
the `jecfa.Rproj` project file.

You are now ready to run the pipeline by interactively by call `.run()`
on the console, or in the background by calling `.background_run()` on
the console. Moreover, every time you will spin-up the container you
have access to all the targets’ objects created/updated by the last
pipeline execution by calling `tar_read(<unquoted_target_name>)` in the
R console within the RStudio Server console.

Once you have finished your work, you can stop the container by running:

``` bash
docker-compose down
```

### Notes on Docker (TL;DR)

If you cloned the project from GitHub, the docker image is defined in
the `Dockerfile`. The `docker-compose.yaml` file is used to setup the
environment, and the `Makefile` is used to manage the container.

You can start the container by running `make up` in the terminal, and
stop it by running `make down`. You can also run the container directly
with custom options (bypassing compose) by running `make run` in the
terminal (see the tag `run` of the `Makefile`).

To run the container effectively, we suggest to bind some internal
folder to the host machine, so you will not lose your work when the
container is stopped. By default, `docker-compose.yaml` binds the
`_targets/`, `data/`, `output/`, and `report/` folders to the host
machine using docker-dedicated volumes. You can change this
configuration by editing the `docker-compose.yaml` file (e.g., to bind
them on accessible folders on your host machine \<note: we discourage
this\>).

## Local RStudio

To run the pipeline in your local RStudio, you need to clone the project
from GitHub, and open the project in RStudio. To do that, you can open
RStudio, and click on `File` -\> `New Project...` -\> `Version Control`
-\> `Git`, and paste the URL of the project repository in the
`Repository URL` field.

You will also need to install all the dependencies of the project.
Project’s dependencies are automatically managed by `renv`, so you would
need to install `renv` and restore the project dependencies. To do that,
you can open the project in RStudio, and run `renv::restore()`, and
follow the instructions.(Ushey and Wickham 2024)

After that, you can open the project ad usual, and run the pipeline by
interactively by call `.run()` on the console, or you can run the
pipeline in the background by calling `.background_run()` on the
console.

Note: a start-up message will always guide you on how to run the
pipeline every time you start the project.

> REMINDER: you do need to run the pipeline only to execute/update it,
> i.e., to create/update the targets. This in general will be required
> only once (or at updates). Once you have execute the pipeline at least
> once, you can always have access the every defined targets by calling
> `tar_read(<unquoted_target_name>)` in the R console!

## Installing and Using the Project as an R Package

This project can be easily installed as an R package, giving you access
to all the functions and dataset documentation. You have two main
options for using the project: installing it as a package or loading it
directly from the cloned repository.

### Option 1: Installing the Package

1.  **Install the Package from GitHub:**

You can install the package directly from GitHub using the `devtools`
package. If you don’t have `devtools` installed, you can install it
first:

``` r
install.packages("devtools")
```

Then, install the package using:

``` r
devtools::install_github("UBESP-DCTV/jecfa")
```

2.  **Load the Package:**

After installation, load the package with:

``` r
library(jecfa)
```

### Option 2: Loading from a Cloned Repository

1.  **Clone the Repository:**

First, clone the repository to your local machine using Git:

``` bash
git clone https://github.com/UBESP-DCTV/jecfa
cd jecfa
```

2.  (After opening R on the project) **Load the Project without
    Installation:**

If you prefer not to install the package, you can load it directly from
(an R session started/activated on the project) the cloned repository
using `devtools`:

``` r
devtools::load_all()
```

### Accessing Functions and Dataset Documentation

Regardless of the method you choose, you can access the functions and
dataset documentation easily. For example, to view the documentation for
the `jecfaDistiller` dataset, use:

``` r
?jecfaDistiller
```

Similarly, you can access documentation for other dataset and functions
included in the package using their respective names:

``` r
?jecfa_tm_full
?jecfa_augmented
?jecfa
```

## Code of Conduct

Please note that the jecfa project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

# References

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-R-targets" class="csl-entry">

Landau, William Michael. 2024. *Targets: Dynamic Function-Oriented
Make-Like Declarative Pipelines*. <https://docs.ropensci.org/targets/>.

</div>

<div id="ref-R-renv" class="csl-entry">

Ushey, Kevin, and Hadley Wickham. 2024. *Renv: Project Environments*.
<https://rstudio.github.io/renv/>.

</div>

</div>
