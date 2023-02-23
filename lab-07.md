Lab 07 - University of Edinburgh Art Collection
================
Zheqi
2/23

### Load packages and data

``` r
library(tidyverse) 
library(skimr)
library(rvest)
# set url
first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read html page
page <- read_html(first_url)
```

``` r
page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text()
page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()
titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()
page %>%
  html_nodes(".iteminfo") %>%   # same nodes
  html_node("h3 a") %>%         # as before
  html_attr("href")             # but get href attribute instead of text
```

``` r
links <- page %>%
  html_nodes(".iteminfo") %>%   # same nodes
  html_node("h3 a") %>%
  html_attr("href") %>%
  str_replace(".record", "https://collections.ed.ac.uk/art/record")
```

``` r
artists <- page %>%
  html_nodes(".artist") %>%
  html_text() %>%
  str_squish()
```

``` r
titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()
art_first_page <- tibble(
  title = titles, 
  link = links, 
  artist = artists
  )

art_first_page
```

    ## # A tibble: 10 × 3
    ##    title                                                  link            artist
    ##    <chr>                                                  <chr>           <chr> 
    ##  1 Unknown (1960)                                         .https://colle… Robin…
    ##  2 Madonna of the Roses (2007)                            .https://colle… Racha…
    ##  3 Standing Male Nudes (1950)                             .https://colle… Sheil…
    ##  4 The Misadventure (1989)                                .https://colle… John …
    ##  5 Seated Male Nude (1965)                                .https://colle… J Lord
    ##  6 Seated Female Nude (1953)                              .https://colle… Lilia…
    ##  7 Untitled - Still Life with Flowers and Pitchers (1963) .https://colle… Helen…
    ##  8 Untitled (12 Jun 2014)                                 .https://colle… Norma…
    ##  9 Untitled - Snowy Landscape (1962)                      .https://colle… Geoff…
    ## 10 Woman Seated (1954)                                    .https://colle… John …

``` r
second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

page <- read_html(second_url)

# scrape titles ----------------------------------------------------------------

titles <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_text() %>%
  str_squish()

# scrape links -----------------------------------------------------------------

links <- page %>%
  html_nodes(".iteminfo") %>%
  html_node("h3 a") %>%
  html_attr("href") %>%
  str_replace("\\.", "___")

# scrape artists ---------------------------------------------------------------

artists <- page %>%
  html_nodes(".artist") %>%
  html_text() %>%
  str_squish()

# put together in a data frame -------------------------------------------------

second_ten <- tibble(
  title = titles,
  artist = artists,
  link = links
)
```

``` r
function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape titles ----------------------------------------------------------------
  
  titles <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_text() %>%
    str_squish()
  
  # scrape links -----------------------------------------------------------------
  
  links <- page %>%
    html_nodes(".iteminfo") %>%
    html_node("h3 a") %>%
    html_attr("href") %>%
    str_replace("\\.", "___")
  
  # scrape artists ---------------------------------------------------------------
  
  artists <- page %>%
    html_node(".artist") %>%
    html_text() %>%
    str_squish()
  
  # put together in a data frame -------------------------------------------------
  
  art_first_page <- tibble(
    title = titles,
    artist = artists,
    link = links
  )

  
}
```

    ## function(url){
    ##   
    ##   # read page
    ##   page <- read_html(url)
    ##   
    ##   # scrape titles ----------------------------------------------------------------
    ##   
    ##   titles <- page %>%
    ##     html_nodes(".iteminfo") %>%
    ##     html_node("h3 a") %>%
    ##     html_text() %>%
    ##     str_squish()
    ##   
    ##   # scrape links -----------------------------------------------------------------
    ##   
    ##   links <- page %>%
    ##     html_nodes(".iteminfo") %>%
    ##     html_node("h3 a") %>%
    ##     html_attr("href") %>%
    ##     str_replace("\\.", "___")
    ##   
    ##   # scrape artists ---------------------------------------------------------------
    ##   
    ##   artists <- page %>%
    ##     html_node(".artist") %>%
    ##     html_text() %>%
    ##     str_squish()
    ##   
    ##   # put together in a data frame -------------------------------------------------
    ##   
    ##   art_first_page <- tibble(
    ##     title = titles,
    ##     artist = artists,
    ##     link = links
    ##   )
    ## 
    ##   
    ## }

``` r
#same results.
```

### Exercise 9

``` r
uoe_art <- uoe_art %>%
  separate(title, into = c("title", "date"), sep = "\\(") %>%
  mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
  select(title, artist, year, ___)
```

    ## Error: <text>:4:32: unexpected input
    ## 3:   mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
    ## 4:   select(title, artist, year, __
    ##                                   ^

### Exercise 10

Remove this text, and add your answer for Exercise 10 here. Add code
chunks as needed. Don’t forget to label your code chunk. Do not use
spaces in code chunk labels.

### Exercise 11

…

Add exercise headings as needed.
