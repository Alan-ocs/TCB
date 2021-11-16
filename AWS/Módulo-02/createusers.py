import boto3, random, string, csv
iam = boto3.client('iam')

length = 16

filename = "usuarios.csv"
  
fields = []
rows = []
  

with open(filename, 'r') as csvfile:
    csvreader = csv.reader(csvfile)
      
    fields = next(csvreader)
  
    for row in csvreader:
        rows.append(row)

        iam.create_user(UserName=row[0])

        chars = string.ascii_letters + string.digits + '!@#$%^&*()}{][~_-'
        rnd = random.SystemRandom()
        RPassword = (''.join(rnd.choice(chars) for i in range(length)))

        print("Creating the user {}".format(row[0]))
        response = iam.create_login_profile(
            UserName=row[0],
            Password=RPassword,
            PasswordResetRequired=True
        )
        print("Adding the user {} in the group {} with the password {}".format(row[0],row[1],RPassword))
        response = iam.add_user_to_group(
            GroupName=row[1],
            UserName=row[0]
        )