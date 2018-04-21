echo enter the folder where md is located: 
read -r folder
for file in $folder/* 
do
  if [ ${file: -3} == ".md" ]
  then
    lowdown $file > ${file:0:-3}.html
  fi
done
