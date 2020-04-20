
s1="      Link :"
s2=" Quad/Chan :"
for i in range(60): #q00c0
    s1+="         {:0>3d}       ".format(i)
    s2+="        q{:0>2d}c{}      ".format(int(i/4.),i%4)
print (s1)
print (s2)
