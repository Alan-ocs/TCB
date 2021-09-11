import random, string

length = 16
chars = string.ascii_letters + string.digits + '!@#$%^&*()}{][~_-'

rnd = random.SystemRandom()
YourPass = ''.join(rnd.choice(chars) for i in range(length))
print(YourPass)
