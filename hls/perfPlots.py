import ROOT
from collections import OrderedDict
pi=ROOT.TMath.Pi() #3.141593
COLZ=[1,2,3,4,6]
# helpers 

nparts = [1,10,50,100,150]
files = { n: ROOT.TFile("output/hists_n{}_10k.root".format(n),"read") for n in nparts}

opts = { #OrderedDict()
    "met_ref": {"norm": 1, "logy":0, "ymax":0.4, "rms":0, },
    "met_diff_zoom": {"norm": 1, "logy":1, "rms":1, },
    "met_rel_zoom": {"norm": 1, "logy":1, "rms":1, },
    "metphi_diff_zoom": {"norm": 1, "logy":1, "rms":1, },
}

for hname in opts:
    # get hists and process if needed
    hists = {n: files[n].Get(hname) for n in nparts}
    if opts[hname]["norm"]:
        for h in hists.values():
            if h.Integral(): h.Scale(1./h.Integral())

    #configure the canvas, pad
    ROOT.gStyle.SetOptStat(0)
    c = ROOT.TCanvas("canv","",750,750)
    pad = ROOT.TPad("pad", "pad", .005, .01, .995, .995)
    pad.Draw()
    pad.cd()

    ROOT.gPad.SetLeftMargin(0.17)
    ROOT.gPad.SetRightMargin(0.05)
    ROOT.gPad.SetBottomMargin(0.1)
    ROOT.gPad.SetTopMargin(0.05)
    if opts[hname]["logy"]:
        pad.SetLogy()

    b = hists[1].Clone("tmp")
    b.Reset()
    b.Draw()
    if "ymax" in opts[hname]:
        b.SetMaximum( opts[hname]["ymax"] )
    
    b.GetXaxis().SetTitleOffset(1.2)
    b.GetYaxis().SetTitleOffset(1.5)
    b.GetYaxis().SetLabelSize(0.04)
    b.GetYaxis().SetTitleSize(0.04)
    b.Draw("")

    for ih,n in enumerate(nparts):
        h = hists[n]
        col = COLZ[ih]
        h.SetLineWidth(2)
        h.SetMarkerStyle(20)
        h.SetLineColor(col)
        h.SetMarkerColor(col)        
        h.Draw("hist same")
        # h.Draw("same plc pmc")

    
    ll = ROOT.TLatex()
    ll.SetNDC()
    ll.SetTextFont(72)
    ll.DrawLatex(.20,.89,"#scale[0.9]{CMS}")
    ll.SetTextFont(42)
    ll.DrawLatex(.30,.89,"#scale[0.9]{Internal}")

    #create and fill legend
    leg = ROOT.TLegend(.20,.76, 0.85,.91)
    leg.SetTextFont(42)
    leg.SetHeader("")
    leg.SetNColumns(2)
    for n in nparts:
        suf=""
        if opts[hname]["rms"]:
            suf = " (RMS {:.3f})".format(hists[n].GetRMS())
        leg.AddEntry(hists[n], "{} input{}{}".format(n,"s"*(n>1),suf),"pel")

    #draw the legend
    leg.SetFillStyle(0)
    leg.SetFillColor(0)
    leg.SetBorderSize(0)
    leg.Draw()
    
    c.SaveAs("output/test_"+hname+".pdf")
    del c
        
