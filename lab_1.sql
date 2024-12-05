create database sem_4

--lab_1

-- Create Artists Table
CREATE TABLE Artists (
    Artist_id INT PRIMARY KEY,
    Artist_name NVARCHAR(255)
);

-- Create Albums Table
CREATE TABLE Albums (
    Album_id INT PRIMARY KEY,
    Album_title NVARCHAR(255),
    Artist_id INT FOREIGN KEY REFERENCES Artists(Artist_id),
    Release_year INT
);

-- Create Songs Table
CREATE TABLE Songs (
    Song_id INT PRIMARY KEY,
    Song_title NVARCHAR(255),
    Duration Decimal (3,2),
    Genre NVARCHAR(255),
    Album_id INT FOREIGN KEY REFERENCES Albums(Album_id)
);

-- Insert Data into Artists Table
INSERT INTO Artists (Artist_id, Artist_name) VALUES
(1,'Aparshakti Khurana'),
(2,'Ed Sheeran'),
(3,'Shreya Ghoshal'),
(4,'Arijit Singh'),
(5,'Tanishk Bagchi');

-- Insert Data into Albums Table
INSERT INTO Albums (Album_id, Album_title, Artist_id, Release_year) VALUES
(1001,'Album1', 1, 2019),
(1002,'Album2', 2, 2015),
(1003,'Album3', 3, 2018),
(1004,'Album4', 4, 2020),
(1005,'Album5', 2, 2020),
(1006,'Album6', 1, 2009);

-- Insert Data into Songs Table
INSERT INTO Songs (Song_id, Song_title, Duration, Genre, Album_id) VALUES
(101, 'Zaroor', 2.55, 'Feel good', 1001),
(102, 'Espresso', 4.10, 'Rhythmic', 1002),
(103, 'Shayad', 3.20, 'Sad', 1003),
(104, 'Roar', 4.05, 'Pop', 1002),
(105, 'Everybody Talks', 3.35, 'Rhythmic', 1003),
(106, 'Dwapara', 3.54, 'Dance', 1002),
(107, 'Sa Re Ga Ma', 4.20, 'Rhythmic', 1004),
(108, 'Tauba', 4.05, 'Rhythmic', 1005),
(109, 'Perfect', 4.23, 'Pop', 1002),
(110, 'Good Luck', 3.55, 'Rhythmic', 1004);


--Part – A
--1. Retrieve a unique genre of songs.

  select distinct genre from Songs
--2. Find top 2 albums released before 2010.
   select top 2 Album_id
   from Albums
   where  Release_year<2010
--3. Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
     insert into Songs values(1245, 'Zaroor', 2.55, 'Feel good', 1005)
--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’

       update Songs
	   set Genre='happy'
	   where Song_title='zaroor'

	   select * from Songs
--5. Delete an Artist ‘Ed Sheeran’

     delete from Artists
	 where Artist_name='Ed Sheeran'

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]

     alter table  Songs
	 add  Ratings decimal(3,2)
	 select *from Songs
--7. Retrieve songs whose title starts with 'S'.
       select song_title 
	   from Songs
	   where  Song_title like 's%'
--8. Retrieve all songs whose title contains 'Everybody'.
        select * 
		from  Songs
		where Song_id like '%Everybody%'
--9. Display Artist Name in Uppercase.
    select UPPER(Artist_name) 
	from Artists
--10. Find the Square Root of the Duration of a Song ‘Good Luck’
     select SQRT(Duration) 
	 from Songs
	 where Song_title='Good luck'
           
--11. Find Current Date.

   select GETDATE()
--12. Find the number of albums for each artist.
   
     select  Artists.Artist_name,count(Album_id)
	 from  Albums
	 join Artists
	 on Albums.Artist_id=Artists.Artist_id
	 group by Artists.Artist_name
--13. Retrieve the Album_id which has more than 5 songs in it.
     select Albums.Album_id, COUNT(Albums.Album_id)  AS SONGSMAX
	 from Albums
	 join songs
	 on Albums.Album_id= Songs.Album_id
	 GROUP BY Albums.Album_id 
	 HAVING COUNT(Albums.Album_id) >5
	 


--14. Retrieve all songs from the album 'Album1'. (using Subquery)
        
		select * from songs
		where Album_id=(
		SELECT Album_id FROM Albums
		WHERE Album_title='ALBUM1'
		)
 
--   15. Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)

  SELECT Album_title 
  from  Albums
  where Artist_id = (
  select Artist_id from Artists
  where Artist_name='Aparshakti Khurana')
--16. Retrieve all the song titles with its album title.
     select Songs.Song_title  ,Albums.Album_title
	from Songs
	 join Albums
	 on Songs.Album_id=Albums.Album_id
--17. Find all the songs which are released in 2020.
   select songs.Song_title from Songs
   join Albums
   on Albums.Album_id=Songs.Album_id
   where Albums.Release_year=2020
--18. Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
    create view Fav_Songs
	as 
	select * from Songs
	where song_id 
--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
    update Fav_Songs
	set Song_title='Jannat'
	where Song_id=101
--20. Find all artists who have released an album in 2020.

	select Artist_name
	from Artists
	join Albums
	on Artists.Artist_id=Albums.Artist_id
	where Albums.Release_year >2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration. 
	select  Songs.* 
	from Songs
	join Albums
	on Albums.Album_id=Songs.Album_id
	join Artists
	on Artists.Artist_id=Albums.Artist_id
	where Artists.Artist_name='Shreya Ghoshal'
	order by Songs.Duration

  select * from Albums;


--  Part – B 
--22. Retrieve all song titles by artists who have more than one album. 

SELECT s.Song_title
FROM Songs s
JOIN Albums a ON s.Album_id = a.Album_id
JOIN Artists ar ON a.Artist_id = ar.Artist_id
WHERE ar.Artist_id IN (
    SELECT Artist_id
    FROM Albums
    GROUP BY Artist_id
    HAVING COUNT(*) > 1
);

	
--23. Retrieve all albums along with the total number of songs. 
    select Albums.Album_title,SUM(Songs.Song_id)
	from Albums
	join Songs
	on Songs.Album_id=Albums.Album_id
	group by Albums.Album_title

--24. Retrieve all songs and release year and sort them by release year.
	select songs.Song_title ,Albums.Release_year 
	from Songs
	join Albums
	on Albums.Album_id=Songs.Album_id
	order by Albums.Release_year
--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs. 
      SELECT s.Genre, COUNT(s.Song_id) AS TotalSongs
		FROM Songs s
		GROUP BY s.Genre
		HAVING COUNT(s.Song_ID) > 2;

--26. List all artists who have albums that contain more than 3 songs.
	select Artists.Artist_name
	from Artists
	join Songs
	on Artists.Artist_id=Artists.Artist_id
	group by Artists.Artist_name
	having count(Songs.Song_id) >3

--Part – C 
--27. Retrieve albums that have been released in the same year as 'Album4' 
        select Albums.Album_id
		from Albums
		where Album_title= (
		 select Album_title from Albums
		 where Album_title='Album4' 
			)
--28. Find the longest song in each genre 
	SELECT Genre, MAX(Duration) AS LongestDuration
	FROM Songs
	GROUP BY Genre;

	 
	
--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
     select Songs.Song_title
	 from Songs
	 join Albums
	 on Albums.Album_id=Songs.Song_id
	 where Album_title like '%Album%'
--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.

	select Artists.Artist_name,sum(Songs.Duration)
	from Songs
	join Albums
	on Songs.Album_id=Albums.Album_id

	join Artists
	on Artists.Artist_id=Albums.Artist_id

	group by Artists.Artist_name
	
	having sum(Songs.Duration) >15
