file_Usage_Thresold=60
df -Ph | grep -vE "filesystem /tmpfs/none"
while read line
do   
	file_name=$(echo$line | awk '{print$1}')
	file_usage=$(echo$line | awk '{print$5}' | sed 's/%//g')
	echo "file sys name:$file_name, file sys usage:$file_usage"
        if [ "$file_usage -gt $file_Usage_Thresold" ]
        then 		
           echo "$file_name:$file_usage" >> file_sys_usage.txt
	fi
done	
cont=$(cat file_sys_usage.txt | wc -l)
if [ $cont -gt 0 ]
then
   echo " some file system is exceded is more than thresold"
   echo -e "Subject:Alert \n\n $(cat file_sys_usage.txt) \n" | sendmail "gaddameedirakesh01@gmail.com"
fi   
