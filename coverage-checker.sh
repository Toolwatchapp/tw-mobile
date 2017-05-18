count=$(grep "<span class=\"strong\">100% </span>" coverage/index.html | wc -l);

if [ "$count" -ne 4 ] 
then
    echo "Coverage isn't 100%"
    exit 1
else
    echo "Coverage is 100%"
fi