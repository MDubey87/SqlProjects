/*1-Which artist has the most songs in the top streamed list of 2023?*/
SELECT artist_name,count(*) as song_count
FROM streamed_songs
where released_year=2023
group by artist_name
order by song_count DESC
Limit 1

/*2-What is the average number of streams for songs released in each month of 2023?*/
SELECT released_month, Avg(streams)::numeric(10,0) as avg_streams
FROM streamed_songs
where released_year=2023
group by released_month
order by released_month ASC

/*3-Are songs with higher danceability percentages generally more popular (i.e. have more streams)?*/
Select 
Case 
When danceability<=25 then '0-25%'
When danceability <=50 then '26-50%'
When danceability <=75 then '51-75%'
Else '76-100%' 
End as danceability_group,
Avg(streams)::numeric(10,0) as avg_streams
from streamed_songs
group by danceability_group
order by avg_streams DESC

/*4-What percentage of songs in the top songs 2023 were actually released in 2023?*/
with songs_count as 
(
Select Count(*) as total_count,
Sum(case when released_year=2023 then 1 else 0 end) as count_2023
from streamed_songs)
Select (count_2023*100)/total_count as count_percentage
from songs_count