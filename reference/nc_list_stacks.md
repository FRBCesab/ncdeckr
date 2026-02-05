# List details of all stacks for a board

Performs an HTTP request (GET method) at the endpoint
`/boards/{boardId}/stacks` of the Nextcloud Deck API to retrieve details
of all stacks of an active Deck board.

## Usage

``` r
nc_list_stacks(board_id)
```

## Arguments

- board_id:

  a `integer` of length 1. The identifier of the board. Use
  [`nc_list_boards()`](https://frbcesab.github.io/ncdeckr/reference/nc_list_boards.md)
  to get this value.

## Value

A `data.frame` with the following columns:

- `board_id`: the identifier of the board

- `id`: the identifier of the stack

- `title`: the name of the stack

- `n_cards`: the number of cards in the stack

## Examples

``` r
if (FALSE) { # \dontrun{
## List details of all Nextcloud stacks of a board
nc_list_stacks()
} # }
```
