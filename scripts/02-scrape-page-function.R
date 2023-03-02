# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# function: scrape_page --------------------------------------------------------

scrape_page <- function(url){
  
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
    str_replace("\\.", "https://collections.ed.ac.uk/art")
  
  # scrape artists ---------------------------------------------------------------
  
  artists <- page %>%
    html_nodes(".artist") %>%
    html_text() %>%
    str_squish()
  
  # put together in a data frame -------------------------------------------------
  
  art_first_page <- tibble(
    title = titles,
    artist = artists,
    link = links
  )

  
}


add_two <- function(x){
  x + 2
}
add_two(3)
add_two(10)

scrape_page(first_url)
scrape_page(second_url)