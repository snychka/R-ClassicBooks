library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# https://readr.tidyverse.org/reference/read_delim.html
titles <- read_csv('data/titles.csv')
stats <- read_csv('data/stats.csv')

# https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/join
books <- inner_join(titles, stats)
# https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/filter
# dickens <- filter(books, author == 'Dickens, Charles')
dickens <- filter(books, author == 'blargh')

# alternate way of doing above, so 2.6
# https://www.rdocumentation.org/packages/stringr/versions/1.4.0/topics/str_detect
# guessed at directly using column name ... yay R :)
# dickens <- filter(books, str_detect(author, 'Dickens'))

# https://www.rdocumentation.org/packages/dplyr/versions/0.7.8
# pedagogically resonable imo:  need to know/guess can assign examples
# to a var.
dickens_stats = dickens %>% select(id, words, sentences, to_be_verbs, contractions, pauses, cliches, similes)

published <- read_csv('data/published.csv')
time <- inner_join(published, dickens_stats)

# https://www.rdocumentation.org/packages/tidyr/versions/0.8.3/topics/gather
time_long <- gather(time, 'type', 'value', words:similes)

# https://ggplot2.tidyverse.org/reference/ggplot.html
# linked to from task 13
# seems if need to specify arg then it's col.-name needs to be a string
p <- ggplot(time_long, aes(year, value, color='type')) + geom_line()

plot(p)
