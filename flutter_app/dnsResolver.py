import dns.resolver

uri = "cloud.8wbw9av.mongodb.net"
answers = dns.resolver.resolve(uri, 'SRV')
for rdata in answers:
    print(rdata)
