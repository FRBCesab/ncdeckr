# List details of all boards

Performs an HTTP request (GET method) at the endpoint `/boards` of the
Nextcloud Deck API to retrieve details of all Deck boards (including
deleted and archived boards).

## Usage

``` r
nc_list_boards(archived = FALSE, deleted = FALSE)
```

## Arguments

- archived:

  a `logical` of length 1. If `TRUE` returns also archived boards.
  Default is `FALSE`.

- deleted:

  a `logical` of length 1. If `TRUE` returns also deleted boards.
  Default is `FALSE`.

## Value

A `data.frame` with the following columns:

- `id`: the identifier of the board

- `title`: the name of the board

- `owner`: the owner of the board

- `color`: the color of the board

- `archived`: is the board archived?

- `deleted`: is the board deleted?

- `n_stacks`: the number of stacks in the board

- `n_labels`: the number of labels in the board

## Examples

``` r
if (FALSE) { # \dontrun{
## List details of all Nextcloud boards
nc_list_boards()

## List details of all Nextcloud boards (including archived ones)
nc_list_boards(archived = TRUE)

## List details of all Nextcloud boards (including deleted ones)
nc_list_boards(deleted = TRUE)
} # }
```
