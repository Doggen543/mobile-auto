#Global variables setting...
*** Variables ***
# ``site`` for element, valid value are "stg" , "prd"
${env}    stg
# ``device_name`` for mobile
${device_name}
# ``mobile`` for element, valid value could be "android" , "ios"
${mobile}
${delay}    3s
${timeout}  10s
&{domains}    stg=https://stg-mbk.migo.com.tw
&{headers}    Content-Type=application/json    
&{CONNECT_DEVICES}   Samsung_A505=R58M73JANNN     HUAWEI=5BM7N18515001137    p=

${search_name}  John Wick: Chapter 2

#99999999998 account info
#Profile
${my_fullname}  Migouser
${my_gender}    Male
${my_birthdaty}     01.01.1994
${my_ig}    qaq
#My Rewards 
${my_rewards}   5
#Download queue
${my_download_queue}  Sector 7
#Favorite movie
${my_saved_items}  Sector 7

#Movie for parental control 
#R13+ media : Taxi Driver, Hello Stranger, Sumber Rezeki
${parental_control_movie}  