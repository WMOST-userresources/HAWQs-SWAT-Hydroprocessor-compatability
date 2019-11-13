####
#File to automatically change headers of SWAT files (.gw, .hru, .sol) for hydroprocessor input
#Created by: Tim Stagnitta 5/25/2018
#Updated by: Ryan Sullivan 7/27/2019

##Change working directory to where SWAT input files under TXtInOut folder
setwd("C:\\Users\\Rsulli05\\OneDrive - Environmental Protection Agency (EPA)\\Profile\\Desktop\\Quapaw Demo Files\\quapaw-demo- Veg Filter Strip\\TxtInOut")

#list .hru, .gw, and .sol files only
files_hru<-list.files(pattern="\\<\\d(?:.+)\\.hru")
files_gw<-list.files(pattern="\\.gw")
files_sol<-list.files(pattern="\\.sol")

files<-c(files_hru,files_gw,files_sol)


#loop to automatically change headers in HAWQS/SWAT files for use with hydroprocessor
for(i in seq(1,length(files))){
  file_header<-readLines(files[i],n=1)
  file_all<-readLines(files[i])
  
  split_header<-strsplit(file_header,split=" ")
  
  
  Head1<-"HAWQS v1"
  Head2<-split_header[[1]][1]#".hru"
  Head3<-"file"
  Head4<-"created"
  Head5<-paste(split_header[[1]][10],split_header[[1]][11],sep=" ")#5/8/2018 6:26:18"
  Head6<-"AM."#change
  
  split_sub<-strsplit(split_header[[1]][5],":")
  Head7<-paste(split_sub[[1]][1],": ",split_sub[[1]][2],sep="")#"Subbasin:"
  
  Head8<-paste(split_header[[1]][15],",",sep="")#"(0109000403),"
  
  split_hru<-strsplit(split_header[[1]][4],":")
  Head9<-paste(split_hru[[1]][1],": ",split_hru[[1]][2],sep="")#"HRU:"
  
  
  subbasin_num<-strsplit(split_header[[1]][15],"[[:punct:]]")[[1]][2]
  luse<-strsplit(split_header[[1]][7],"[[:punct:]]")[[1]][2]
  soil<-strsplit(split_header[[1]][8],"[[:punct:]]")[[1]][2]
  
  Head10<-paste("(",subbasin_num,luse,soil,")",",",sep="")#(0109000403MA007URHD1),"
  
  split_luse<-strsplit(split_header[[1]][7],":")
  Head11<-paste("Landuse",": ",split_luse[[1]][2],",",sep="")
  
  split_soil<-strsplit(split_header[[1]][8],":")
  Head12<-paste(split_soil[[1]][1],": ",split_luse[[1]][2],",",sep="")
  
  split_slope<-strsplit(split_header[[1]][9],":")
  Head13<-paste(split_slope[[1]][1],": ",split_slope[[1]][2],sep="")
  
  new_header<-paste(Head1,Head2,Head3,Head4,Head5,Head6,Head7,Head8,Head9,Head10,Head11,Head12,Head13,sep=" ")
  
  file_all[1]<-new_header
  write(file_all,files[i])
  # Head13<-"Landuse:"
  # Head14<-"URHD," #change
  # Head15<-"Soil:"
  # Head16<-"MA007,"#chnage
  # Head17<-"Slope:"
  # Head18<-"0-1"#chnage
  
}

