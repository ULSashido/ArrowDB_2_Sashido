<img width="277" src="https://github.com/ULSashido/ArrowDB_2_Sashido/blob/main/src/arrowToSashido.png">

# ArrowDB 2 Sashido Migration Tool
 Migration Tool for ArrowDB to Sashido. This tool allows you to migrate Users from ArrowDB to Sashido, and have CustomObjects Migrations to have Pointers to the User that created the CustomObjects.
 
 Custom Objects with relations to other Custom Objects, would require modifying the code to handle your situation. An example is provided in the code similar to the manner Users have relations to Custom Objects.
 
 ## For Mac Users
 You can Run the .dmg packaged App from the [Releases](https://github.com/ULSashido/ArrowDB_2_Sashido/releases).
 
 ## For Windows Users
 You can download the [.air file](https://github.com/ULSashido/ArrowDB_2_Sashido/releases) and run it with AIR Runtime. Download here https://airsdk.harman.com/runtime prior to installing .air file.
 
 <img width="400" alt="Settings" src="https://user-images.githubusercontent.com/80773129/112351223-13d03400-8ca0-11eb-9563-71e1283cbef3.png">
 
 1- You must enter the ArrowDB `App Key` (source of the Data)
 
 2- You must enter all the fields in order to Migrate the Data into Sashido (the Destination DB).
 
 # Users Migration Notice
 ArrowDB does not export the passwords of Users, therefore a default Password is required in order to create Sashido Users Accounts. This can later be handled with "[Forgot My Password](https://blog.sashido.io/emails-and-custom-user-facing-pages/)" in Sashido in order for the User to reset their password.
 
 Custom Objects of Users will be transfered, `createdAt` and `updatedAt` will be converted to Date Objects in Sashido.
 
 # Custom Objects Notice
 By Default, if the Users have been migrated a Hash Table is set up so that the Users of Custom Objects maintain their Relations. If Other Relations to Other Objects are required, a sample code is provided to handle these, however you would need to re-compile the Application to cater to your needs.
 
 ## Limitations
 You can only Migrate 1000 Rows at a time, a Next 1000 button is provided for the case you have more than 1000 Rows.
