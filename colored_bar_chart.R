install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)
df <- read.csv(file = "/Users/gregorybagramyan/Documents/DataAnalysis/What major label rules the game ?/major_labels_top_200.csv", header = TRUE, sep = ",")
df

df <- df %>% group_by(Artist, major.label) %>% 
  summarise(Tracks_per_Artist = n()) %>% 
  arrange(desc(Tracks_per_Artist))
df

df <- head(df, 8)
df

df_bar_plot <- ggplot(data = df, aes(x=reorder(Artist, -Tracks_per_Artist), y= Tracks_per_Artist)) +
  geom_bar(stat = 'identity', aes(fill = major.label)) + xlab("") +
  ylab("Number of Tracks") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  guides(fill=guide_legend(title="Major Labels")) + my_scale

df_bar_plot

### NOW LET'S SEE THE ARTIST WITH THE MOST CUMULATED STREAMS 
df_2 <- read.csv(file = "/Users/gregorybagramyan/Documents/DataAnalysis/What major label rules the game ?/major_labels_top_200.csv", header = TRUE, sep = ",")
df_2

df_2 <- df_2 %>% group_by(Artist, major.label) %>% 
  summarise(Total_Streams = sum(Streams)) %>% 
  arrange(desc(Total_Streams))
df_2

df_2 <- head(df_2, 8)
df_2

df_bar_plot_2 <- ggplot(data = df_2, aes(x=reorder(Artist, -Total_Streams), y= Total_Streams)) + 
  geom_bar(stat = 'identity', aes(fill = major.label)) + xlab("") +
  ylab("Total Streams") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  guides(fill=guide_legend(title="Major Labels")) + my_scale

df_bar_plot_2
### IT's almost no fun, unfortunatly Kanye and J.Cole are leaving the top 8
# ANd lil Nas X and the Disney Artist are entering it. 
#(+ Colors do not match the previous bar chart but since it's not that 
#important/interesting I'm not going to do anything about that ... )



##############
my_colors <- c("burlywood2", "dodgerblue3", "darkolivegreen3", "lightgoldenrod1", "chocolate3", "darkorchid3")      
#for colors : http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
df$major.label <- factor(df$major.label)
df_2$major.label <- factor(df_2$major.label)
names(my_colors) <- levels(factor(c(levels(df$major.label), levels(df_2$major.label))))

my_scale <- scale_fill_manual(name = "Major Labels", values = my_colors)
#Now we just have to add + my_scale for each bar chart 

df_bar_plot <- ggplot(data = df, aes(x=reorder(Artist, -Tracks_per_Artist), y= Tracks_per_Artist)) +
  geom_bar(stat = 'identity', aes(fill = major.label)) + xlab("") +
  ylab("Number of Tracks") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  guides(fill=guide_legend(title="Major Labels")) + my_scale

df_bar_plot

df_bar_plot_2 <- ggplot(data = df_2, aes(x=reorder(Artist, -Total_Streams), y= Total_Streams)) + 
  geom_bar(stat = 'identity', aes(fill = major.label)) + xlab("") +
  ylab("Total Streams") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  guides(fill=guide_legend(title="Major Labels")) + my_scale

df_bar_plot_2

#PROBLEM SOLVED 
#solution found on : https://statisticsglobe.com/r-assign-fixed-colors-to-categorical-variables-in-ggplot2-plot

