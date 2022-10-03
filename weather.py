from codecs import latin_1_decode
import requests
import datetime


ct = datetime.datetime.now()

key = 'a19913b0ea32583092ca45f0af7e0e1e'

city = 'Guadalajara'

lat = 20.6667

lon = -103.3333

#weather_prec = requests.get(
#    f"https://api.openweathermap.org/data/2.5/onecall?lat={lat}&lon={lon}&exclude=current,minutely,hourly,alerts&appid={key}&units=metric")

#print(weather_prec.json())

weather_raw = requests.get(
    f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={key}&units=metric")

construct_url = "https://api.openweathermap.org/data/2.5/weather?q=Guadalajara&appid=a19913b0ea32583092ca45f0af7e0e1e&units=metric"
response = requests.get(construct_url)

list_of_data = response.json()

#print(weather_raw.json())

country = weather_raw.json()['sys']['country']

weather = weather_raw.json()['weather'][0]['description']

temp = weather_raw.json()['main']['temp']

#precp = weather_prec.json()['daily'][0]['pop']
#precp = precp*100

print(f"Weather report for: {city}, {country}")
print(f"                    {weather}")
print(f"                    {temp} °C")
#print(f"                    {precp}%")
print(f"                    {ct.strftime('%d/%m/%Y %H:%M:%S')}")


f = open('/bin/weather.html','w')
    
html_data = f"""

<table border="1">
<tr>
    <td>City</td>
    <td>ESTADO</td>
    <td>Country</td>
    <td>Time</td>
    <td>Temp</td>
    <td>Description</td>
    <td>Humidity</td>   
</tr>
<tr>
    <td>Guadalajara</td>
    <td>Jalisco</td>
    <td>{str(list_of_data['sys']['country'])}</td>
    <td>{(ct.strftime('%d/%m/%Y %H:%M:%S'))}</td>
    <td>{str(list_of_data['main']['temp']) + '°C'}</td>
    <td>{str(list_of_data['weather'][0]['description'])}</td>
    <td>{str(list_of_data['main']['humidity'])}</td>
</tr>

</table>
"""

f.write(html_data)
f.close()


#Add the following code after Humidity
#<td>Precp</td>

#Add the following code after humidity data
#<td>{str(precp) + '%'}</td>