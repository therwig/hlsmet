
import ROOT
from collections import OrderedDict
pi=ROOT.TMath.Pi() #3.141593

# helpers 
def book(h,name,n,a,b,title=""):
    h[name]=ROOT.TH1F(name,title,n,a,b)
def book2(h,name,nx,ax,bx,ny,ay,by,title=""):
    h[name]=ROOT.TH2F(name,title,nx,ax,bx,ny,ay,by)
def bookp(h,name,nx,ax,bx,ay,by,title="",err="s"):
    h[name]=ROOT.TProfile(name,title,nx,ax,bx,ay,by,err)
def draw(t,var,hname):
    t.Draw(var+">>"+hname)

# tree
fname="results.txt"
fname="full_results.txt"
for npart in [1,10,50,100,150]:
    t = ROOT.TTree("t","")
    fname="output/n{}_10k.txt".format(npart)
    t.ReadFile(fname,"ref:refphi:refx:refy:refrat:hw:hwphi:hwx:hwy:hwrat:hwratNoLUT")
    # if "full" in fname: t.ReadFile(fname,"ref:refphi:refx:refy:refrat:hw:hwphi:hwx:hwy:hwrat:hwratNoLUT")
    # else: t.ReadFile(fname,"ref:refphi:hw:hwphi")
    
    #hists
    h=OrderedDict()
    
    # basic
    book(h,"met_ref",40,0,1600,";reference MET [GeV]")
    book(h,"met_hw" ,40,0,1600,";HW MET [GeV]")
    book(h,"met_ref_fine",1024,0,1024,";[GeV]")
    book(h,"met_hw_fine" ,1024,0,1024,";[GeV]")
    book(h,"metphi_ref",40,-pi,pi)
    book(h,"metphi_hw" ,40,-pi,pi)
    book(h,"metphi_hw_int" ,1025,-512.5,512.5)
    book(h,"metphi_ref_fine",540,-pi/256*270,pi/256*270) # keep bin sizes
    book(h,"metphi_hw_fine" ,540,-pi/256*270,pi/256*270)
    
    #differences
    book(h,"met_diff",80,-200,200,";MET(HW)-MET(ref) [GeV]")
    book(h,"met_rel",80,0,2,";MET(HW)/MET(ref)")
    book(h,"metphi_diff",80,-1,1,";phi(HW)-phi(ref)")
    book(h,"met_diff_zoom",80,-20,20,";MET(HW)-MET(ref) [GeV]")
    book(h,"met_rel_zoom",80,0.9,1.1,";MET(HW)/MET(ref)")
    book(h,"metphi_diff_zoom",80,-0.1,0.1,";phi(HW)-phi(ref)")
    # versus vals
    book2(h,"2d_met_diff",10,0,1000,40,-200,200,";MET(ref) [GeV];MET(HW)-MET(ref) [GeV]")
    book2(h,"2d_met_rel",10,0,1000,40,0,2,";MET(ref) [GeV];MET(HW)/MET(ref)")
    book2(h,"2d_metphi_diff",12,-pi/5*6,pi/5*6, 40,-1,1,";phi(ref) ;phi(HW)-phi(ref)")
    bookp(h,"p_met_diff",10,0,1000,-200,200,";MET(ref) [GeV];MET(HW)-MET(ref) [GeV]")
    bookp(h,"p_met_rel",10,0,1000,0,2,";MET(ref) [GeV];MET(HW)/MET(ref)")
    bookp(h,"p_metphi_diff",48,-pi/5*6,pi/5*6,-1,1,";phi(ref) ;phi(HW)-phi(ref)")
    
    #extras
    if "full" in fname:
        book(h,"metx_rel",80,-2,2,";METX(HW)/METX(ref)")
        book(h,"mety_rel",80,-2,2,";METY(HW)/METY(ref)")
        book(h,"ratio_rel",80,-2,2,";tanPhi(HW)/tanPhi(ref)")
        book(h,"ratioNoLUT_rel",80,-2,2,";tanPhi(HW)/tanPhi(ref)")
    
    
    
    
    
    # reference met, phi
    draw(t,"ref","met_ref")
    draw(t,"ref","met_ref_fine")
    draw(t,"refphi","metphi_ref")
    draw(t,"refphi","metphi_ref_fine")
    
    # hardware met, phi
    draw(t,"hw","met_hw")
    draw(t,"hw","met_hw_fine")
    draw(t,"hwphi","metphi_hw")
    draw(t,"hwphi","metphi_hw_int")
    draw(t,"hwphi","metphi_hw_fine")
    
    # differences
    for s in ["","_zoom"]:
        draw(t,"hw-ref","met_diff"+s)
        draw(t,"hw/ref","met_rel"+s)
        draw(t,"hwphi-refphi","metphi_diff"+s)
    #2d
    draw(t,"hw-ref:ref"         ,"2d_met_diff")
    draw(t,"hw/ref:ref"         ,"2d_met_rel")
    draw(t,"hwphi-refphi:refphi","2d_metphi_diff")
    #profile
    draw(t,"hw-ref:ref"         ,"p_met_diff")
    draw(t,"hw/ref:ref"         ,"p_met_rel")
    draw(t,"hwphi-refphi:refphi","p_metphi_diff")
    
    #extras
    if "full" in fname:
        draw(t,"hwx/refx","metx_rel")
        draw(t,"hwy/refy","mety_rel")
        draw(t,"refrat/hwrat","ratio_rel")
        draw(t,"hwratNoLUT/hwrat","ratioNoLUT_rel")
    
    
    
    outname="output/hists_n{}_10k.root".format(npart)
    f = ROOT.TFile(outname,"recreate")
    for x in h: h[x].Write()
    f.Close()
