Deliverables and other information
==================================

DDL scripts
===========
database_structure_only.sql is the SQL creation script in DDL scripts

db_data_only.sql is the SQL insertion script in DDL scripts

How to test that they work??
===========================
 1. Open workbench (BAH!!! it sucks) 
 2. Control A control C the database_structure_only.sql and then control V as a query. 
 3. Then run the lightning.

 Better SQL GUI software
 =======================

  1. Download SQLYOG from http://code.google.com/p/sqlyog/downloads/detail?name=SQLyog-11.0.1-0.x64Community.exe&can=2&q=


Logical Design
==============

need to redo because the foreign keys need to point to the 
same components of the same composite primary keys


How did you load the last two tables, `trip` and `ride` csv files? (In case got kaypoh asked you)
=================================================================================================
I assume you have loaded the other 8 tables using the instructions from the PDF.
Your remarks MUST be loaded after you load trip.


 1. I went to WAMP > Apache > Alias directories > Add alias 
 2. You will see a black color command prompt
 3. type in <uploadcsv> without the <> !!
 4. then open windows explorer and copy the full path to the uploadcsv_scripts folder
 You should get something like:

 C:\Users\Jinq Yi\Dropbox\SMU\Term2\IS202-DM\Project\Jinq\uploadcsv_scripts

 Copy the full path

 5. Left click the top left hand corner of the command prompt > Edit > Paste
 6. You should see a Alias created. Press Enter to exit...
 7. I went to WAMP > Apache > Alias directories > http://localhost/uploadcsv/ > Edit alias

 You should see the following:

Alias /uploadcsv/ "C:\Users\Jinq Yi\Dropbox\SMU\Term2\IS202-DM\Project\Jinq\uploadcsv_scripts/" 

<Directory "C:\Users\Jinq Yi\Dropbox\SMU\Term2\IS202-DM\Project\Jinq\uploadcsv_scripts/">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride all
        Order allow,deny
    Allow from all
</Directory>

Add the words Require local before the </Directory>

It should now look like this:

Alias /uploadcsv/ "C:\Users\Jinq Yi\Dropbox\SMU\Term2\IS202-DM\Project\Jinq\uploadcsv_scripts/" 

<Directory "C:\Users\Jinq Yi\Dropbox\SMU\Term2\IS202-DM\Project\Jinq\uploadcsv_scripts/">
    Options Indexes FollowSymLinks MultiViews
    AllowOverride all
        Order allow,deny
    Allow from all
    Require local
</Directory>

CLose and SAVE!!


 8. Now go to browser and type http://localhost/uploadcsv/uploadtrip.php to upload the data from C:/IS202/Data/trip.csv into the database dm_phase2 table trip.
 	**NOTE!! If you have error, one of the following is not there:**
   a. You do not have C:/IS202/Data/trip.csv
   b. Your database is not named correctly or you password is wrong. Please check uploadcsv_scripts/constants.php and change accordingly.

   **NOTE!! it will take at least 20 seconds! Do not press refresh too quickly!!**

   You should see something like this:

   Connection succeeded
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted 


 9. Now go to browser and type http://localhost/uploadcsv/uploadtransaction.php to upload the data from C:/IS202/Data/ride.csv into the database dm_phase2 table transaction.
 	**NOTE!! If you have error, one of the following is not there:**
   a. You do not have C:/IS202/Data/ride.csv
   b. Your database is not named correctly or you password is wrong. Please check uploadcsv_scripts/constants.php and change accordingly.

   **NOTE!! it will take at least 20 seconds! Do not press refresh too quickly!!**

   You should see something like this:

   Connection succeeded
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted
Record inserted 


 10. Now you can load your remarks...



USEFUL INFORMATION
-====================-
1. Total unique buses 41
2. buses that have rides = 40
3. among buses that are driven by JulDecBabies & capacity 72 = 18
4. among buses that are driven by JulDecBabies & capacity 46 = 22

how to set variables in mysql
=============================
set @variable_name = 123;
http://dev.mysql.com/doc/refman/5.0/en/set-statement.html


