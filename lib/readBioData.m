function dataOut = readBioData(data)
    readData = py.urllib.request.urlopen(data).read();
    dataOut = string(readData.decode('utf-8'));
end

