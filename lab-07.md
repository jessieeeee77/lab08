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
    ##  1 Untitled (2004)                                        .https://colle… Rebec…
    ##  2 Untitled (1963)                                        .https://colle… Andre…
    ##  3 Seated Female Nude (1994-1995)                         .https://colle… Nicho…
    ##  4 Portrait of a Woman (1959)                             .https://colle… Willi…
    ##  5 Untitled - Abstract Figures and Shapes (1965-1966)     .https://colle… James…
    ##  6 Untitled (2003)                                        .https://colle… Andre…
    ##  7 Portrait of a Woman (1956)                             .https://colle… John …
    ##  8 Seated Female Nude (1953)                              .https://colle… Lilia…
    ##  9 Madonna of the Roses (2007)                            .https://colle… Racha…
    ## 10 Untitled - Still Life with Flowers and Pitchers (1963) .https://colle… Helen…

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
  page <- read_html(urls)
  
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
    str_replace("\\.", "https://collections.ed.ac.uk/art")
  
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
    ##   page <- read_html(urls)
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
    ##     str_replace("\\.", "https://collections.ed.ac.uk/art")
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

``` r
root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
```

### Exercise 9

``` r
uoe_art <- uoe_art %>%
  separate(title, into = c("title", "date"), sep = "\\(") %>%
  mutate(year = str_remove(date, "\\)") %>% as.numeric()) %>%
  select(title, artist, year)
```

    ## Error in separate(., title, into = c("title", "date"), sep = "\\("): object 'uoe_art' not found

### Exercise 10

Remove this text, and add your answer for Exercise 10 here. Add code
chunks as needed. Don’t forget to label your code chunk. Do not use
spaces in code chunk labels.

### Exercise 11

…

Add exercise headings as needed.
