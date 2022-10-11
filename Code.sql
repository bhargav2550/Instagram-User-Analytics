-- query to select the top 5 oldest users of instagram
select * from users order by created_at limit 5;

-- query to select the day of the week on which most users are registering
select day_of_the_week,count(day_of_the_week)as created_day
from
(
SELECT *,weekday(created_at)as day_of_the_week from users
)a
group by day_of_the_week
order by created_day desc ;

-- the users who never post a single photo on instagram
select users.id,username,created_at from users
left join photos
on users.id=photos.user_id
where image_url is null;

-- query to select the top 5 hashtags which are often tagged
select *
from
(
select tags.id,tag_name,tag_id,count(tag_id)as no_of_times_tagged from tags
join photo_tags 
on tags.id=photo_tags.tag_id 
group by tag_id
order by no_of_times_tagged desc
)a 
limit 5;

-- query to select average number of posts by users on instagram
SELECT ID,
COUNT(ID) AS TOTAL_NO_OF_PHOTOS,
MAX(DISTINCT USER_ID)AS TOTAL_NO_OF_USERS,
COUNT(ID)/MAX(DISTINCT USER_ID) AS AVERAGE_NO_OF_POSTS_PER_USER FROM PHOTOS;

-- the users(bots) who liked every single photo on instagram
SELECT ID,USERNAME,USERS.CREATED_AT,COUNT(USER_ID)AS NO_OF_PHOTOS_LIKED FROM USERS
JOIN LIKES 
ON USERS.ID=LIKES.USER_ID
GROUP BY USER_ID
HAVING COUNT(USER_ID)=(SELECT COUNT(ID) FROM PHOTOS);

-- the user who gets more number of likes for a single photo
select id,username,a.created_at,photo_id,max(most_likes)as most_likes from
(
select id,username,users.created_at,user_id,photo_id,likes.created_at as liked_time,count(photo_id) as most_likes from users
left join likes
on users.id=likes.user_id
group by photo_id
order by most_likes desc
)a;
