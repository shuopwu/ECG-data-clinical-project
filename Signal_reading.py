
import sys
import numpy as np
import struct
import matplotlib.pyplot as plt
from scipy import signal


#Shuopeng Wu DSC450 project 
def onel(y1):
    plt.plot(y1[:1000],'green')
    ax = plt.gca() 
    ax.set_xticklabels([0,1,2,3,4,5])
    plt.ylabel('mv-by-lead1')
    plt.xlabel('seconds')
    plt.title('lead 1 in 5 sec')
    plt.show()

def threel(y1,y2,y3):
    plt.plot(y1[:1000],'red',y2[:1000],'blue',y3[:1000],'green')
    ax = plt.gca()
    ax.set_xticklabels([0,1,2,3,4,5])
    plt.ylabel('mv-by-leads')
    plt.xlabel('seconds')
    plt.title('three leads in 5 sec')
    plt.show()

def findpeak(y,t): #t is the thresthold
    count = 0
    for i in range(len(y)-1): 
        if (y[i] > y[i-1]) and (y[i] > y[i+1]) and (y[i] > t):
            #print (y[i])
            count += 1
    return count


def hat(y,a,b):
    peaky = []
    vec2 = signal.ricker(20, 4)
    for j in range(a,b):
        yii = y[j:j+20]
        yiii = yii * vec2
        peaky.append(sum(yiii))        
    return peaky


def findpeak(y,t): #t is the thresthold
    count = 0
    for i in range(len(y)-1): 
        if (y[i] > y[i-1]) and (y[i] > y[i+1]) and (y[i] > t):
            #print (y[i])
            count += 1
    return count


def hat(y,a,b):
    peaky = []
    vec2 = signal.ricker(20, 4)
    for j in range(a,b):
        yii = y[j:j+20]
        yiii = yii * vec2
        peaky.append(sum(yiii))        
    return peaky


def HR(y,t):
    total = len(y)
    beats = []
    for z in range(0,total-12000,12000):   
        potential = hat(y,z,z+12000)
        beat = findpeak(potential,t)
        beats.append(beat)
    return beats 


def smooth(y):
    total = len(y)
    l = []
    for i in range(0+2,total-2):
        yq = y[i-2:i+2]
        yq = np.array(yq)
        m = np.median(yq)
        l.append(m)
    return l

def part3(y,t):
    yv = HR(y,t)
    yp = smooth(yv)
    plt.plot(yp)
    plt.ylabel('HR')
    plt.xlabel('hours')
    ax = plt.gca()
    plt.xlim(0,len(yp))
    ax.set_xticklabels([0,4,8,12,16,20,24])
    plt.title('HR-plot-final')
    plt.show()



if __name__ == "__main__":

    filename = sys.argv[-1]
    try: 
        f = open(filename,'rb')

    except IOError:
        print ('%s cannot be opened' % filename)
        sys.exit()

    else:
        # magic number
        magicnumber = np.fromfile(f, dtype = np.dtype('a8'), count = 1)[0]

        # check sum
        chesksum = np.fromfile(f, dtype = np.uint16, count = 1)[0]

        #header
        Var_length_block_size = np.fromfile(f, dtype = np.int32, count = 1)[0] 
        Sample_Size_ECG =  np.fromfile(f, dtype = np.int32, count = 1)[0] 
        Offset_var_length_block =  np.fromfile(f, dtype = np.int32, count = 1)[0] 
        Offset_ECG_block =  np.fromfile(f, dtype = np.int32, count = 1)[0] 
        File_version =  np.fromfile(f, dtype = np.int16, count = 1)[0] 
        First_name =  np.fromfile(f, dtype = np.dtype('a40'), count = 1)[0]
        Last_name =  np.fromfile(f, dtype = np.dtype('a40'), count = 1)[0]
        ID = np.fromfile(f, dtype = np.dtype('a20'), count = 1)[0]
        Sex = np.fromfile(f, dtype = np.int16, count = 1)[0] 
        Race = np.fromfile(f, dtype = np.int16, count = 1)[0] 
        Birth_Date = np.fromfile(f, dtype = np.int16, count = 3) 
        Record_Date =  np.fromfile(f, dtype = np.int16, count = 3) 
        File_Date =  np.fromfile(f, dtype = np.int16, count = 3) 
        Start_Time =  np.fromfile(f, dtype = np.int16, count = 3) 
        nbLeads = np.fromfile(f, dtype = np.int16, count = 1)[0] 
        Lead_Spec = np.fromfile(f, dtype = np.int16, count = 12) 
        Lead_Qual = np.fromfile(f, dtype = np.int16, count = 12) 
        Resolution = np.fromfile(f, dtype = np.int16, count = 12) 
        Pacemaker = np.fromfile(f, dtype = np.int16, count = 1)[0] 
        Recorder =  np.fromfile(f, dtype = np.dtype('a40'), count = 1)[0]
        Sampling_Rate = np.fromfile(f, dtype = np.int16, count = 1)[0] 
        Propreitary  = np.fromfile(f, dtype = np.dtype('a80'), count = 1)[0]
        Copyright =  np.fromfile(f, dtype = np.dtype('a80'), count = 1)[0]
        Reserved =  np.fromfile(f, dtype = np.dtype('a88'), count = 1)[0]

        # read Variable length block
        if (Var_length_block_size >0):
            dt = dtype((str,Var_length_block_size))
            varblock = np.fromfile(f, dtype = dt, count = 1)[0]

        # ECG data
        Sample_per_lead = int(Sample_Size_ECG/nbLeads)

        ecgSig = np.zeros((nbLeads, Sample_per_lead))
        for i in range(Sample_per_lead):
            for j in range(nbLeads):
                ecgSig[j][i] =  np.fromfile(f, dtype = np.int16, count = 1)[0]
        f.close()

        y1 = ecgSig[0][:] * (Resolution[0]/1000000.0)
        y2 = ecgSig[1][:] * (-Resolution[1]/1000000.0) #we reverse the lead2 by -1
        y3 = ecgSig[2][:] * (-Resolution[2]/1000000.0) #we reverse the lead3 by -1


        if len(sys.argv) ==2:
            onel(y1)
        elif len(sys.argv) >2:
            if sys.argv[1] == '-L':
                threel(y1,y2,y3)
            elif sys.argv[1] == '-HR':
                part3(y1,0.9)   
        else:
            print ("entetred wrong")