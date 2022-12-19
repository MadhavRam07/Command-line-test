<<PROJECT
Name: V.Madhav
Date: 29-08-2022
Description: Command Line Test
PROJECT
login="y"                              #intializing yes in variable login
while [ $login = "y" ]                 #if selected y using for loop
do
    echo "Login Details"               #showing user the login details
    echo "1) Sign up"                  #showing Sign up as option 1
    echo "2) Sign in"                  #showing Sign in as option 2
    read -p "Enter the choice : " choice #reading the option of user
    case $choice in                    #using case statements to work options
        1)a=(`cat "user.csv"`)         #storing all the usernames in array a
            flag=1                     #using a variable flag as 1
            while [ $flag -eq 1 ]      #if flag equals 1 then using while loop
            do
                read -p "Enter the New username : " username   #reading new username from user
                flag=0                #making flag value to 0
                for i in ${a[@]}      #using for loop username array size
                do
                    if [ $username = $i ]  #checking if new user matches any name in a
                    then
                        echo -e "\e[31m$username already exist.\e[39m"  #if matches showing it already exists
                        flag=1         #and also making the flag value as 1
                    fi
                done
                if [ $flag -eq 0 ]     #if names doesn't match then giving flag value as 0
                then
                    echo $username >> user.csv  #storing username in user.csv file
                fi
            done
            echo "Enter the password : "  #showing user to enter password
            read -s password            #reading password in hidden format
            flag=1                      #giving flag value as 1
            while [ $flag -eq 1 ]       #if flag equals 1 then using while loop
            do
                echo "Enter the password again : "  #showing user for confirmation password
                read -s confirmpassword             #reading the confirmationpassword in hidden format
                flag=0                  #giving flag value as 0
                if [ "$password" != "$confirmpassword" ] #checking that both the passwords matches or not
                then
                    echo -e "\e[31mEntered password does not match. Make sure you enter same password.\e[39m"  #if doesn't match showing user to enter password again
                    flag=1              #making flag variable as 1
                else
                    echo -e "\e[32mAccount Successfully Created.\e[39m"   #if matches then showing that account created successfully
                fi
            done
            if [ $flag -eq 0 ]         #if flag value equals to 0
            then
                echo $password >> password.csv  #then storing the password in password.csv file
            fi ;;                      #closing 1 case statement
        2)a=(`cat "user.csv"`)         #storing the user.csv elements in array a
            b=(`cat "password.csv"`)   #storing the password.csv in array b
            flag=0                     #making the variable flag as 0
            read -p "Enter Username : " username  #reading the username from the user
            for i in `seq 0 1 $((${#a[@]}-1))`     #using for loop for no.of a element times
            do
                if [ $username = ${a[i]} ]  #checking if both the names matches
                then
                    flag=1             #if matches then making flag value as 1
                    index=$i           #and also storing i in variable index
                fi
            done
            if [ $flag -eq 0 ]         #if flag value is equal to 0
            then
                echo -e "\e[31mUsername does not exist.Press 1 to Signup at login details.\e[39m" #showing user that name doesn't exist if not matches
                break                  #and also breaking the if condition
            else 
                count=1                #if names matches then giving count variable as 1
                while [ $count -eq 1 ] #using while loop if count equals 1
                do
                    count=0            #then giving count value as 0
                    echo "Enter Password : "   #asking user to give password for username
                    read -s password   #reading the password given by the user
                    if [ "$password" != "${b[$index]}" ] #checking that password matches or not  with particular username
                    then
                        echo -e "\e[31mInvalid,make sure you enter correct password\e[39m" #showing invalid if password doesn't match with username
                        count=1        #giving the count value as 1
                    fi
                done
                if [ $count -eq 0 ]    #if count value is equal to 0
                then
                    echo -e "\e[31mLogin Successful.\e[39m"  #then showing user that login is successfull
                fi
            fi
            mark=0                            #making a variable mark as 0
            c=(`cat correct_ans.txt`)         #storing the correct ans in an array c
            flag=0                            #making flag variable equal to 0
            while [ $flag -eq 0 ]             #using while loop if flag equals 0
            do
                echo "1)Take the test"        #showing user to take test as 1
                echo "2)Exit"                 #showing user to exit as 2
                read -p "Enter the choice : " choice  #reading the choice of the user
                if [ $choice -eq 1 -o $choice -eq 2 ] #checking if user choice is 1 or 2
                then 
                    flag=1                    #making the flag variable as 1
                fi
                index=0                       #giving the index value as 0
                case $choice in               #using case statements for the user choice
         1)for j in `seq 5 5 50`              #using for loop for j number of times
           do
               index=$(($index+1))            #increasing the index val with 1 for every seq
               head -$j questions.txt | tail -5 #showing user every lines of data
               for i in `seq 9 -1 0`          #using for loop[ to define time
               do
                   echo -n -e "\rChoose the option : $i : \c" #showing user to choose the option 
                   read -t 1 user_ans         #reading the user answer
                   if [ -n "$user_ans" ]      #if user answer matches options
                   then
                       break                  #breaking the if condition
                   else
                       user_ans=e             #if not matches then declaring user ans as e
                   fi
               done
               if [ $user_ans = "e" ]         #chekcing if user ans is e
               then
                   echo "Time out"            #if e then showing time out
               fi
               if [ $user_ans = ${c[$index-1]} ] #checking if user ans is correct or not
               then
                   echo -e "\e[42mCORRECT\e[49m" #if correct then showing it as correct
                   mark=$(($mark+1))          #also increasing the mark value
               else
                   echo -e "\e[41mWRONG\e[49m"  #if user ans is wrong then showing wrong
               fi
           done
           echo -e "Total Mark : \e[42m$mark/10\e[49m" ;; #showing user the total marks they scored
          2)echo -e "\e[31mDid not took the test.\e[39m" ;; #if selected option 2 then showing exit option
          *)echo -e "\e[31mEnter only 1(or)2.\e[39m" ;;   #if selected any other option, showing to choose btw 1 and 2
      esac 
  done ;;                                      #closing the case statement of choice
*)echo "Press other than "y" to  exit" ;;      #showing user to press other letter to exit
esac
read -p "Do you want to continue(y/n) ? " login #reading the login option from the user
done                                           #end of the begining while loop
