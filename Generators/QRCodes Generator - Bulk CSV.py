import csv
import qrcode

with open('links.csv') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        data = row[0]
        filename = data[23:] + '.png'
        img = qrcode.make(data)
        img.save(filename)
