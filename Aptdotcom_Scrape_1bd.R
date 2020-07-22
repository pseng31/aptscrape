##################################
# VERSION: Does not email data
##################################

#-------------------------------- SETUP --------------------------------#

# Check if rvest package is installed and if not, install it
if(!require(rvest)){
  install.packages("rvest")
}

# Load rvest package
library('rvest')


#----------------------------- SCRAPE DATA -----------------------------#

###################
### 800 CARLYLE ###
###################

# Store URL to be scraped
c800_url <- 'https://www.apartments.com/800-carlyle-alexandria-va/v9t8f4f/'

# Read HTML from URL
c800_webpage <- read_html(c800_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
c800_fp_html <- html_nodes(c800_webpage,'.name')
c800_rent_html <- html_nodes(c800_webpage,'.rent')
c800_bed_html <- html_nodes(c800_webpage,'.beds')
c800_bath_html <- html_nodes(c800_webpage,'.baths')
c800_sqft_html <- html_nodes(c800_webpage,'.sqft')
c800_avail_html <- html_nodes(c800_webpage,'.available')

# Convert data to text
c800_fp <- html_text(c800_fp_html)
c800_rent <- html_text(c800_rent_html)
c800_bed <- html_text(c800_bed_html)
c800_bath <- html_text(c800_bath_html)
c800_sqft <- html_text(c800_sqft_html)
c800_avail <- html_text(c800_avail_html)

# Quick look at data
# head(c800_fp)
# head(c800_rent)
# head(c800_bed)
# head(c800_bath)
# head(c800_sqft)
# head(c800_avail)

# Data cleanup
c800_rent <- gsub("\r\n","",c800_rent)
c800_rent <- gsub(" ","",c800_rent)
c800_rent <- substring(c800_rent,1,regexpr("-",c800_rent)-1)
# head(c800_rent)

c800_bed <- c800_bed[grep("[,-]",c800_bed)*-1]
c800_bed <- gsub("BR","Bed",c800_bed)
c800_bed <- gsub("Bedroom","Bed",c800_bed)
c800_bed <- gsub("Beds","Bed",c800_bed)
c800_bed <- gsub("Studio","0Bed",c800_bed)
c800_bed <- gsub("\r\n","",c800_bed)
c800_bed <- gsub(" ","",c800_bed)
c800_bed <- substring(c800_bed,1,1)
# head(c800_bed)

c800_bath <- gsub("BA","Bath",c800_bath)
c800_bath <- gsub("Bathroom","Bath",c800_bath)
c800_bath <- gsub("Baths","Bath",c800_bath)
c800_bath <- gsub("Bathrooms","Bath",c800_bath)
c800_bath <- gsub("\r\n","",c800_bath)
c800_bath <- gsub(" ","",c800_bath)
c800_bath <- substring(c800_bath,1,1)
# head(c800_bath)

c800_sqft <- gsub(" ","",c800_sqft)
c800_sqft <- gsub("SqFt","", c800_sqft)

c800_avail <- gsub("\r\n","",c800_avail)
c800_avail <- gsub(" ","",c800_avail)
c800_avail <- gsub("AvailableNow","Now",c800_avail)
# head(c800_avail)

# Grab only 1bd info
c800_fp_1bd <- c800_fp[which(c800_bed=="1")]
c800_rent_1bd <- c800_rent[which(c800_bed=="1")]
c800_bed_1bd <- c800_bed[which(c800_bed=="1")]
c800_bath_1bd <- c800_bath[which(c800_bed=="1")]
c800_sqft_1bd <- c800_sqft[which(c800_bed=="1")]
c800_avail_1bd <- c800_avail[which(c800_bed=="1")]

# Grab available apts
c800_fp_1bd <- c800_fp_1bd[which(c800_avail_1bd!="NotAvailable")]
c800_rent_1bd <- c800_rent_1bd[which(c800_avail_1bd!="NotAvailable")]
c800_bed_1bd <- c800_bed_1bd[which(c800_avail_1bd!="NotAvailable")]
c800_bath_1bd <- c800_bath_1bd[which(c800_avail_1bd!="NotAvailable")]
c800_sqft_1bd <- c800_sqft_1bd[which(c800_avail_1bd!="NotAvailable")]
c800_avail_1bd <- c800_avail_1bd[which(c800_avail_1bd!="NotAvailable")]

# Combine 1bd vectors into data frame
num_apt <- length(c800_fp_1bd)
apt <- rep("800 Carlyle",num_apt)
c800_1bd <- data.frame(apt,c800_fp_1bd,c800_rent_1bd,c800_bed_1bd,
                       c800_bath_1bd,c800_sqft_1bd,c800_avail_1bd)
colnames(c800_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                        "AVAILABILITY")
# c800_1bd

# Remove duplicates
c800_1bd <- unique(c800_1bd)
# c800_1bd

# Grab cheapest floor plan
c800_low <- c800_1bd[which.min(c800_1bd$RENT),]
# c800_low

# Grab floor plans available in sep
c800_sep <- c800_1bd[grep("Sep",c800_1bd$AVAILABILITY),]
# c800_sep


#####################
### CARLYLE PLACE ###
#####################

# Store URL to be scraped
cplace_url <- 'https://www.apartments.com/carlyle-place-alexandria-va/f8nwzzt/'

# Read HTML from URL
cplace_webpage <- read_html(cplace_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
cplace_fp_html <- html_nodes(cplace_webpage,'.name')
cplace_rent_html <- html_nodes(cplace_webpage,'.rent')
cplace_bed_html <- html_nodes(cplace_webpage,'.beds')
cplace_bath_html <- html_nodes(cplace_webpage,'.baths')
cplace_sqft_html <- html_nodes(cplace_webpage,'.sqft')
cplace_avail_html <- html_nodes(cplace_webpage,'.available')

# Convert data to text
cplace_fp <- html_text(cplace_fp_html)
cplace_rent <- html_text(cplace_rent_html)
cplace_bed <- html_text(cplace_bed_html)
cplace_bath <- html_text(cplace_bath_html)
cplace_sqft <- html_text(cplace_sqft_html)
cplace_avail <- html_text(cplace_avail_html)

# Quick look at data
# head(cplace_fp)
# head(cplace_rent)
# head(cplace_bed)
# head(cplace_bath)
# head(cplace_sqft)
# head(cplace_avail)

# Data cleanup
cplace_rent <- gsub("\r\n","",cplace_rent)
cplace_rent <- gsub(" ","",cplace_rent)
cplace_rent <- substring(cplace_rent,1,regexpr("-",cplace_rent)-1)
# head(cplace_rent)

cplace_bed <- cplace_bed[grep("[&-]",cplace_bed)*-1]
cplace_bed <- gsub("BR","Bed",cplace_bed)
cplace_bed <- gsub("Bedroom","Bed",cplace_bed)
cplace_bed <- gsub("Beds","Bed",cplace_bed)
cplace_bed <- gsub("Studio","0Bed",cplace_bed)
cplace_bed <- gsub("\r\n","",cplace_bed)
cplace_bed <- gsub(" ","",cplace_bed)
cplace_bed <- substring(cplace_bed,1,1)
# head(cplace_bed)

cplace_bath <- gsub("BA","Bath",cplace_bath)
cplace_bath <- gsub("Bathroom","Bath",cplace_bath)
cplace_bath <- gsub("Baths","Bath",cplace_bath)
cplace_bath <- gsub("Bathrooms","Bath",cplace_bath)
cplace_bath <- gsub("\r\n","",cplace_bath)
cplace_bath <- gsub(" ","",cplace_bath)
cplace_bath <- substring(cplace_bath,1,1)
# head(cplace_bath)

cplace_sqft <- gsub(" ","",cplace_sqft)
cplace_sqft <- gsub("SqFt","", cplace_sqft)

cplace_avail <- gsub("\r\n","",cplace_avail)
cplace_avail <- gsub(" ","",cplace_avail)
cplace_avail <- gsub("AvailableNow","Now",cplace_avail)
# head(cplace_avail)

# Grab only 1bd info
cplace_fp_1bd <- cplace_fp[which(cplace_bed=="1")]
cplace_rent_1bd <- cplace_rent[which(cplace_bed=="1")]
cplace_bed_1bd <- cplace_bed[which(cplace_bed=="1")]
cplace_bath_1bd <- cplace_bath[which(cplace_bed=="1")]
cplace_sqft_1bd <- cplace_sqft[which(cplace_bed=="1")]
cplace_avail_1bd <- cplace_avail[which(cplace_bed=="1")]

# Grab available apts
cplace_fp_1bd <- cplace_fp_1bd[which(cplace_avail_1bd!="NotAvailable")]
cplace_rent_1bd <- cplace_rent_1bd[which(cplace_avail_1bd!="NotAvailable")]
cplace_bed_1bd <- cplace_bed_1bd[which(cplace_avail_1bd!="NotAvailable")]
cplace_bath_1bd <- cplace_bath_1bd[which(cplace_avail_1bd!="NotAvailable")]
cplace_sqft_1bd <- cplace_sqft_1bd[which(cplace_avail_1bd!="NotAvailable")]
cplace_avail_1bd <- cplace_avail_1bd[which(cplace_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(cplace_fp_1bd)
apt <- rep("Carlyle Place",num_apt)
cplace_1bd <- data.frame(apt,cplace_fp_1bd,cplace_rent_1bd,cplace_bed_1bd,
                         cplace_bath_1bd,cplace_sqft_1bd,cplace_avail_1bd)
colnames(cplace_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                          "AVAILABILITY")
# cplace_1bd

# Remove duplicates
cplace_1bd <- unique(cplace_1bd)
# cplace_1bd

# Grab cheapest floor plan
cplace_low <- cplace_1bd[which.min(cplace_1bd$RENT),]
# cplace_low

# Grab floor plans available in sep
cplace_sep <- cplace_1bd[grep("Sep",cplace_1bd$AVAILABILITY),]
# cplace_sep


####################
### CARLYLE MILL ###
####################

# Store URL to be scraped
cmill_url <- 'https://www.apartments.com/carlyle-mill-alexandria-va/hb2rpc2/'

# Read HTML from URL
cmill_webpage <- read_html(cmill_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
cmill_fp_html <- html_nodes(cmill_webpage,'.name')
cmill_rent_html <- html_nodes(cmill_webpage,'.rent')
cmill_bed_html <- html_nodes(cmill_webpage,'.beds')
cmill_bath_html <- html_nodes(cmill_webpage,'.baths')
cmill_sqft_html <- html_nodes(cmill_webpage,'.sqft')
cmill_avail_html <- html_nodes(cmill_webpage,'.available')

# Convert data to text
cmill_fp <- html_text(cmill_fp_html)
cmill_rent <- html_text(cmill_rent_html)
cmill_bed <- html_text(cmill_bed_html)
cmill_bath <- html_text(cmill_bath_html)
cmill_sqft <- html_text(cmill_sqft_html)
cmill_avail <- html_text(cmill_avail_html)

# Quick look at data
# head(cmill_fp)
# head(cmill_rent)
# head(cmill_bed)
# head(cmill_bath)
# head(cmill_sqft)
# head(cmill_avail)

# Data cleanup
cmill_rent <- gsub("\r\n","",cmill_rent)
cmill_rent <- gsub(" ","",cmill_rent)
cmill_rent[grep("-",cmill_rent)] <- substring(cmill_rent[grep("-",cmill_rent)],1,regexpr("-",cmill_rent[grep("-",cmill_rent)])-1)
# head(cmill_rent)

cmill_bed <- cmill_bed[grep("[&-]",cmill_bed)*-1]
cmill_bed <- gsub("BR","Bed",cmill_bed)
cmill_bed <- gsub("Bedroom","Bed",cmill_bed)
cmill_bed <- gsub("Beds","Bed",cmill_bed)
cmill_bed <- gsub("Studio","0Bed",cmill_bed)
cmill_bed <- gsub("\r\n","",cmill_bed)
cmill_bed <- gsub(" ","",cmill_bed)
cmill_bed <- substring(cmill_bed,1,1)
# head(cmill_bed)

cmill_bath <- gsub("BA","Bath",cmill_bath)
cmill_bath <- gsub("Bathroom","Bath",cmill_bath)
cmill_bath <- gsub("Baths","Bath",cmill_bath)
cmill_bath <- gsub("Bathrooms","Bath",cmill_bath)
cmill_bath <- gsub("\r\n","",cmill_bath)
cmill_bath <- gsub(" ","",cmill_bath)
cmill_bath <- substring(cmill_bath,1,1)
# head(cmill_bath)

cmill_sqft <- gsub(" ","",cmill_sqft)
cmill_sqft <- gsub("SqFt","", cmill_sqft)

cmill_avail <- gsub("\r\n","",cmill_avail)
cmill_avail <- gsub(" ","",cmill_avail)
cmill_avail <- gsub("AvailableNow","Now",cmill_avail)
# head(cmill_avail)

# Grab only 1bd info
cmill_fp_1bd <- cmill_fp[which(cmill_bed=="1")]
cmill_rent_1bd <- cmill_rent[which(cmill_bed=="1")]
cmill_bed_1bd <- cmill_bed[which(cmill_bed=="1")]
cmill_bath_1bd <- cmill_bath[which(cmill_bed=="1")]
cmill_sqft_1bd <- cmill_sqft[which(cmill_bed=="1")]
cmill_avail_1bd <- cmill_avail[which(cmill_bed=="1")]

# Grab available apts
cmill_fp_1bd <- cmill_fp_1bd[which(cmill_avail_1bd!="NotAvailable")]
cmill_rent_1bd <- cmill_rent_1bd[which(cmill_avail_1bd!="NotAvailable")]
cmill_bed_1bd <- cmill_bed_1bd[which(cmill_avail_1bd!="NotAvailable")]
cmill_bath_1bd <- cmill_bath_1bd[which(cmill_avail_1bd!="NotAvailable")]
cmill_sqft_1bd <- cmill_sqft_1bd[which(cmill_avail_1bd!="NotAvailable")]
cmill_avail_1bd <- cmill_avail_1bd[which(cmill_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(cmill_fp_1bd)
apt <- rep("Carlyle Mill",num_apt)
cmill_1bd <- data.frame(apt,cmill_fp_1bd,cmill_rent_1bd,cmill_bed_1bd,
                        cmill_bath_1bd,cmill_sqft_1bd,cmill_avail_1bd)
colnames(cmill_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                         "AVAILABILITY")
# cmill_1bd

# Remove duplicates
cmill_1bd <- unique(cmill_1bd)
# cmill_1bd

# Grab cheapest floor plan
cmill_low <- cmill_1bd[which.min(cmill_1bd$RENT),]
# cmill_low

# Grab floor plans available in sep
cmill_sep <- cmill_1bd[grep("Sep",cmill_1bd$AVAILABILITY),]
# cmill_sep


##############################
### MERIDIAN AT EISENHOWER ###
##############################

# Store URL to be scraped
mer_url <- 'https://www.apartments.com/meridian-at-eisenhower-alexandria-va/3n0116d/'

# Read HTML from URL
mer_webpage <- read_html(mer_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
mer_fp_html <- html_nodes(mer_webpage,'.name')
mer_rent_html <- html_nodes(mer_webpage,'.rent')
mer_bed_html <- html_nodes(mer_webpage,'.beds')
mer_bath_html <- html_nodes(mer_webpage,'.baths')
mer_sqft_html <- html_nodes(mer_webpage,'.sqft')
mer_avail_html <- html_nodes(mer_webpage,'.available')

# Convert data to text
mer_fp <- html_text(mer_fp_html)
mer_rent <- html_text(mer_rent_html)
mer_bed <- html_text(mer_bed_html)
mer_bath <- html_text(mer_bath_html)
mer_sqft <- html_text(mer_sqft_html)
mer_avail <- html_text(mer_avail_html)

# Quick look at data
# head(mer_rent)
# head(mer_bed)
# head(mer_bath)
# head(mer_fp)
# head(mer_sqft)
# head(mer_avail)

# Data Cleanup
mer_rent <- gsub("\r\n","",mer_rent)
mer_rent <- gsub(" ","",mer_rent)
mer_rent <- substring(mer_rent,1,regexpr("-",mer_rent)-1)
# head(mer_rent)

mer_bed <- mer_bed[grep("[&-]",mer_bed)*-1]
mer_bed <- gsub("BR","Bed",mer_bed)
mer_bed <- gsub("Bedroom","Bed",mer_bed)
mer_bed <- gsub("Beds","Bed",mer_bed)
mer_bed <- gsub("Studio","0Bed",mer_bed)
mer_bed <- gsub("\r\n","",mer_bed)
mer_bed <- gsub(" ","",mer_bed)
mer_bed <- substring(mer_bed,1,1)
# head(mer_bed)

mer_bath <- gsub("BA","Bath",mer_bath)
mer_bath <- gsub("Bathroom","Bath",mer_bath)
mer_bath <- gsub("Baths","Bath",mer_bath)
mer_bath <- gsub("Bathrooms","Bath",mer_bath)
mer_bath <- gsub("\r\n","",mer_bath)
mer_bath <- gsub(" ","",mer_bath)
mer_bath <- substring(mer_bath,1,1)
# head(mer_bath)

mer_sqft <- gsub(" ","",mer_sqft)
mer_sqft[grep("-",mer_sqft)] <- substring(mer_sqft[grep("-",mer_sqft)],1,regexpr("-",mer_sqft[grep("-",mer_sqft)])-1)
mer_sqft <- gsub("SqFt","",mer_sqft)
# head(mer_sqft)

mer_avail <- gsub("\r\n","",mer_avail)
mer_avail <- gsub(" ","",mer_avail)
mer_avail <- gsub("AvailableNow","Now",mer_avail)
# head(mer_avail)


# Grab only 1bd info
mer_fp_1bd <- mer_fp[which(mer_bed=="1")]
mer_rent_1bd <- mer_rent[which(mer_bed=="1")]
mer_bed_1bd <- mer_bed[which(mer_bed=="1")]
mer_bath_1bd <- mer_bath[which(mer_bed=="1")]
mer_sqft_1bd <- mer_sqft[which(mer_bed=="1")]
mer_avail_1bd <- mer_avail[which(mer_bed=="1")]

# Grab available apts
mer_fp_1bd <- mer_fp_1bd[which(mer_avail_1bd!="NotAvailable")]
mer_rent_1bd <- mer_rent_1bd[which(mer_avail_1bd!="NotAvailable")]
mer_bed_1bd <- mer_bed_1bd[which(mer_avail_1bd!="NotAvailable")]
mer_bath_1bd <- mer_bath_1bd[which(mer_avail_1bd!="NotAvailable")]
mer_sqft_1bd <- mer_sqft_1bd[which(mer_avail_1bd!="NotAvailable")]
mer_avail_1bd <- mer_avail_1bd[which(mer_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(mer_fp_1bd)
apt <- rep("Meridian Eisenhower",num_apt)
mer_1bd <- data.frame(apt,mer_fp_1bd,mer_rent_1bd,mer_bed_1bd,mer_bath_1bd,
                      mer_sqft_1bd,mer_avail_1bd)
colnames(mer_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# mer_1bd

# Remove duplicates
mer_1bd <- unique(mer_1bd)
# mer_1bd

# Grab cheapest floor plan
mer_low <- mer_1bd[which.min(mer_1bd$RENT),]
# mer_low

# Grab floor plans available in sep
mer_sep <- mer_1bd[grep("Sep",mer_1bd$AVAILABILITY),]
# mer_sep

###########################
### CASCADE AT LANDMARK ###
###########################

# Store URL to be scraped
cas_url <- 'https://www.apartments.com/cascade-at-landmark-alexandria-va/qq8eq0z/'

# Read HTML from URL
cas_webpage <- read_html(cas_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
cas_fp_html <- html_nodes(cas_webpage,'.name')
cas_rent_html <- html_nodes(cas_webpage,'.rent')
cas_bed_html <- html_nodes(cas_webpage,'.beds')
cas_bath_html <- html_nodes(cas_webpage,'.baths')
cas_sqft_html <- html_nodes(cas_webpage,'.sqft')
cas_avail_html <- html_nodes(cas_webpage,'.available')

# Convert data to text
cas_fp <- html_text(cas_fp_html)
cas_rent <- html_text(cas_rent_html)
cas_bed <- html_text(cas_bed_html)
cas_bath <- html_text(cas_bath_html)
cas_sqft <- html_text(cas_sqft_html)
cas_avail <- html_text(cas_avail_html)

# Quick look at data
# head(cas_rent)
# head(cas_bed)
# head(cas_bath)
# head(cas_fp)
# head(cas_sqft)
# head(cas_avail)

# Data Cleanup
cas_rent <- gsub("\r\n","",cas_rent)
cas_rent <- gsub(" ","",cas_rent)
#cas_rent <- substring(cas_rent,1,regexpr("-",cas_rent)-1)
# head(cas_rent)

cas_bed <- cas_bed[grep("[&-]",cas_bed)*-1]
cas_bed <- gsub("BR","Bed",cas_bed)
cas_bed <- gsub("Bedroom","Bed",cas_bed)
cas_bed <- gsub("Beds","Bed",cas_bed)
cas_bed <- gsub("Studio","0Bed",cas_bed)
cas_bed <- gsub("\r\n","",cas_bed)
cas_bed <- gsub(" ","",cas_bed)
cas_bed <- substring(cas_bed,1,1)
# head(cas_bed)

cas_bath <- gsub("BA","Bath",cas_bath)
cas_bath <- gsub("Bathroom","Bath",cas_bath)
cas_bath <- gsub("Baths","Bath",cas_bath)
cas_bath <- gsub("Bathrooms","Bath",cas_bath)
cas_bath <- gsub("\r\n","",cas_bath)
cas_bath <- gsub(" ","",cas_bath)
cas_bath <- substring(cas_bath,1,1)
# head(cas_bath)

cas_sqft <- gsub(" ","",cas_sqft)
cas_sqft[grep("-",cas_sqft)] <- substring(cas_sqft[grep("-",cas_sqft)],1,regexpr("-",cas_sqft[grep("-",cas_sqft)])-1)
cas_sqft <- gsub("SqFt","",cas_sqft)
# head(cas_sqft)

cas_avail <- gsub("\r\n","",cas_avail)
cas_avail <- gsub(" ","",cas_avail)
cas_avail <- gsub("AvailableNow","Now",cas_avail)
# head(cas_avail)


# Grab only 1bd info
cas_fp_1bd <- cas_fp[which(cas_bed=="1")]
cas_rent_1bd <- cas_rent[which(cas_bed=="1")]
cas_bed_1bd <- cas_bed[which(cas_bed=="1")]
cas_bath_1bd <- cas_bath[which(cas_bed=="1")]
cas_sqft_1bd <- cas_sqft[which(cas_bed=="1")]
cas_avail_1bd <- cas_avail[which(cas_bed=="1")]

# Grab available apts
cas_fp_1bd <- cas_fp_1bd[which(cas_avail_1bd!="NotAvailable")]
cas_rent_1bd <- cas_rent_1bd[which(cas_avail_1bd!="NotAvailable")]
cas_bed_1bd <- cas_bed_1bd[which(cas_avail_1bd!="NotAvailable")]
cas_bath_1bd <- cas_bath_1bd[which(cas_avail_1bd!="NotAvailable")]
cas_sqft_1bd <- cas_sqft_1bd[which(cas_avail_1bd!="NotAvailable")]
cas_avail_1bd <- cas_avail_1bd[which(cas_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(cas_fp_1bd)
apt <- rep("Cascade",num_apt)
cas_1bd <- data.frame(apt,cas_fp_1bd,cas_rent_1bd,cas_bed_1bd,cas_bath_1bd,
                      cas_sqft_1bd,cas_avail_1bd)
colnames(cas_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# cas_1bd

# Remove duplicates
cas_1bd <- unique(cas_1bd)
# cas_1bd

# Grab cheapest floor plan
cas_low <- cas_1bd[which.min(cas_1bd$RENT),]
# cas_low

# Grab floor plans available in sep
cas_sep <- cas_1bd[grep("Sep",cas_1bd$AVAILABILITY),]
# cas_sep

#############################
### RESERVE AT EISENHOWER ###
#############################

# Store URL to be scraped
res_url <- 'https://www.apartments.com/the-reserve-at-eisenhower-alexandria-va/l5cbyef/'

# Read HTML from URL
res_webpage <- read_html(res_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
res_fp_html <- html_nodes(res_webpage,'.name')
res_rent_html <- html_nodes(res_webpage,'.rent')
res_bed_html <- html_nodes(res_webpage,'.beds')
res_bath_html <- html_nodes(res_webpage,'.baths')
res_sqft_html <- html_nodes(res_webpage,'.sqft')
res_avail_html <- html_nodes(res_webpage,'.available')

# Convert data to text
res_fp <- html_text(res_fp_html)
res_rent <- html_text(res_rent_html)
res_bed <- html_text(res_bed_html)
res_bath <- html_text(res_bath_html)
res_sqft <- html_text(res_sqft_html)
res_avail <- html_text(res_avail_html)

# Quick look at data
# head(res_rent)
# head(res_bed)
# head(res_bath)
# head(res_fp)
# head(res_sqft)
# head(res_avail)

# Data Cleanup
res_rent <- gsub("\r\n","",res_rent)
res_rent <- gsub(" ","",res_rent)
res_rent <- substring(res_rent,1,6)
# head(res_rent)

res_bed <- res_bed[grep("[&-]",res_bed)*-1]
res_bed <- gsub("BR","Bed",res_bed)
res_bed <- gsub("Bedroom","Bed",res_bed)
res_bed <- gsub("Beds","Bed",res_bed)
res_bed <- gsub("Studio","0Bed",res_bed)
res_bed <- gsub("\r\n","",res_bed)
res_bed <- gsub(" ","",res_bed)
res_bed <- substring(res_bed,1,1)
# head(res_bed)

res_bath <- gsub("BA","Bath",res_bath)
res_bath <- gsub("Bathroom","Bath",res_bath)
res_bath <- gsub("Baths","Bath",res_bath)
res_bath <- gsub("Bathrooms","Bath",res_bath)
res_bath <- gsub("\r\n","",res_bath)
res_bath <- gsub(" ","",res_bath)
res_bath <- substring(res_bath,1,1)
# head(res_bath)

res_sqft <- gsub(" ","",res_sqft)
res_sqft[grep("-",res_sqft)] <- substring(res_sqft[grep("-",res_sqft)],1,regexpr("-",res_sqft[grep("-",res_sqft)])-1)
res_sqft <- gsub("SqFt","",res_sqft)
# head(res_sqft)

res_avail <- gsub("\r\n","",res_avail)
res_avail <- gsub(" ","",res_avail)
res_avail <- gsub("AvailableNow","Now",res_avail)
# head(res_avail)


# Grab only 1bd info
res_fp_1bd <- res_fp[which(res_bed=="1")]
res_rent_1bd <- res_rent[which(res_bed=="1")]
res_bed_1bd <- res_bed[which(res_bed=="1")]
res_bath_1bd <- res_bath[which(res_bed=="1")]
res_sqft_1bd <- res_sqft[which(res_bed=="1")]
res_avail_1bd <- res_avail[which(res_bed=="1")]

# Grab available apts
res_fp_1bd <- res_fp_1bd[which(res_avail_1bd!="NotAvailable")]
res_rent_1bd <- res_rent_1bd[which(res_avail_1bd!="NotAvailable")]
res_bed_1bd <- res_bed_1bd[which(res_avail_1bd!="NotAvailable")]
res_bath_1bd <- res_bath_1bd[which(res_avail_1bd!="NotAvailable")]
res_sqft_1bd <- res_sqft_1bd[which(res_avail_1bd!="NotAvailable")]
res_avail_1bd <- res_avail_1bd[which(res_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(res_fp_1bd)
apt <- rep("Reserve",num_apt)
res_1bd <- data.frame(apt,res_fp_1bd,res_rent_1bd,res_bed_1bd,res_bath_1bd,
                      res_sqft_1bd,res_avail_1bd)
colnames(res_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# res_1bd

# Remove duplicates
res_1bd <- unique(res_1bd)
# res_1bd

# Grab cheapest floor plan
res_low <- res_1bd[which.min(res_1bd$RENT),]
# res_low

# Grab floor plans available in sep
res_sep <- res_1bd[grep("Sep",res_1bd$AVAILABILITY),]
# res_sep

############################
### MERIDIAN AT BRADDOCK ###
############################

# Store URL to be scraped
brad_url <- 'https://www.apartments.com/meridian-at-braddock-station-alexandria-va/b9tdjwc/'

# Read HTML from URL
brad_webpage <- read_html(brad_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
brad_fp_html <- html_nodes(brad_webpage,'.name')
brad_rent_html <- html_nodes(brad_webpage,'.rent')
brad_bed_html <- html_nodes(brad_webpage,'.beds')
brad_bath_html <- html_nodes(brad_webpage,'.baths')
brad_sqft_html <- html_nodes(brad_webpage,'.sqft')
brad_avail_html <- html_nodes(brad_webpage,'.available')

# Convert data to text
brad_fp <- html_text(brad_fp_html)
brad_rent <- html_text(brad_rent_html)
brad_bed <- html_text(brad_bed_html)
brad_bath <- html_text(brad_bath_html)
brad_sqft <- html_text(brad_sqft_html)
brad_avail <- html_text(brad_avail_html)

# Quick look at data
# head(brad_rent)
# head(brad_bed)
# head(brad_bath)
# head(brad_fp)
# head(brad_sqft)
# head(brad_avail)

# Data Cleanup
brad_rent <- gsub("\r\n","",brad_rent)
brad_rent <- gsub(" ","",brad_rent)
brad_rent <- substring(brad_rent,1,regexpr("-",brad_rent)-1)
# head(brad_rent)

brad_bed <- brad_bed[grep("[&-]",brad_bed)*-1]
brad_bed <- gsub("BR","Bed",brad_bed)
brad_bed <- gsub("Bedroom","Bed",brad_bed)
brad_bed <- gsub("Beds","Bed",brad_bed)
brad_bed <- gsub("Studio","0Bed",brad_bed)
brad_bed <- gsub("\r\n","",brad_bed)
brad_bed <- gsub(" ","",brad_bed)
brad_bed <- substring(brad_bed,1,1)
# head(brad_bed)

brad_bath <- gsub("BA","Bath",brad_bath)
brad_bath <- gsub("Bathroom","Bath",brad_bath)
brad_bath <- gsub("Baths","Bath",brad_bath)
brad_bath <- gsub("Bathrooms","Bath",brad_bath)
brad_bath <- gsub("\r\n","",brad_bath)
brad_bath <- gsub(" ","",brad_bath)
brad_bath <- substring(brad_bath,1,1)
# head(brad_bath)

brad_sqft <- gsub(" ","",brad_sqft)
brad_sqft[grep("-",brad_sqft)] <- substring(brad_sqft[grep("-",brad_sqft)],1,regexpr("-",brad_sqft[grep("-",brad_sqft)])-1)
brad_sqft <- gsub("SqFt","",brad_sqft)
# head(brad_sqft)

brad_avail <- gsub("\r\n","",brad_avail)
brad_avail <- gsub(" ","",brad_avail)
brad_avail <- gsub("AvailableNow","Now",brad_avail)
# head(brad_avail)


# Grab only 1bd info
brad_fp_1bd <- brad_fp[which(brad_bed=="1")]
brad_rent_1bd <- brad_rent[which(brad_bed=="1")]
brad_bed_1bd <- brad_bed[which(brad_bed=="1")]
brad_bath_1bd <- brad_bath[which(brad_bed=="1")]
brad_sqft_1bd <- brad_sqft[which(brad_bed=="1")]
brad_avail_1bd <- brad_avail[which(brad_bed=="1")]

# Grab available apts
brad_fp_1bd <- brad_fp_1bd[which(brad_avail_1bd!="NotAvailable")]
brad_rent_1bd <- brad_rent_1bd[which(brad_avail_1bd!="NotAvailable")]
brad_bed_1bd <- brad_bed_1bd[which(brad_avail_1bd!="NotAvailable")]
brad_bath_1bd <- brad_bath_1bd[which(brad_avail_1bd!="NotAvailable")]
brad_sqft_1bd <- brad_sqft_1bd[which(brad_avail_1bd!="NotAvailable")]
brad_avail_1bd <- brad_avail_1bd[which(brad_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(brad_fp_1bd)
apt <- rep("Meridian Braddock",num_apt)
brad_1bd <- data.frame(apt,brad_fp_1bd,brad_rent_1bd,brad_bed_1bd,brad_bath_1bd,
                      brad_sqft_1bd,brad_avail_1bd)
colnames(brad_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# brad_1bd

# Remove duplicates
brad_1bd <- unique(brad_1bd)
# brad_1bd

# Grab cheapest floor plan
brad_low <- brad_1bd[which.min(brad_1bd$RENT),]
# brad_low

# Grab floor plans available in sep
brad_sep <- brad_1bd[grep("Sep",brad_1bd$AVAILABILITY),]
# brad_sep

#######################
### SHEFFIELD COURT ###
#######################

# Store URL to be scraped
shef_url <- 'https://www.apartments.com/sheffield-court-arlington-va/0x60xt1/'

# Read HTML from URL
shef_webpage <- read_html(shef_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
shef_fp_html <- html_nodes(shef_webpage,'.name')
shef_rent_html <- html_nodes(shef_webpage,'.rent')
shef_bed_html <- html_nodes(shef_webpage,'.beds')
shef_bath_html <- html_nodes(shef_webpage,'.baths')
shef_sqft_html <- html_nodes(shef_webpage,'.sqft')
shef_avail_html <- html_nodes(shef_webpage,'.available')

# Convert data to text
shef_fp <- html_text(shef_fp_html)
shef_rent <- html_text(shef_rent_html)
shef_bed <- html_text(shef_bed_html)
shef_bath <- html_text(shef_bath_html)
shef_sqft <- html_text(shef_sqft_html)
shef_avail <- html_text(shef_avail_html)

# Quick look at data
# head(shef_rent)
# head(shef_bed)
# head(shef_bath)
# head(shef_fp)
# head(shef_sqft)
# head(shef_avail)

# Data Cleanup
shef_rent <- gsub("\r\n","",shef_rent)
shef_rent <- gsub(" ","",shef_rent)
shef_rent <- substring(shef_rent,1,6)
# head(shef_rent)

shef_bed <- shef_bed[grep("[&-]",shef_bed)*-1]
shef_bed <- gsub("BR","Bed",shef_bed)
shef_bed <- gsub("Bedroom","Bed",shef_bed)
shef_bed <- gsub("Beds","Bed",shef_bed)
shef_bed <- gsub("Studio","0Bed",shef_bed)
shef_bed <- gsub("\r\n","",shef_bed)
shef_bed <- gsub(" ","",shef_bed)
shef_bed <- substring(shef_bed,1,1)
# head(shef_bed)

shef_bath <- gsub("BA","Bath",shef_bath)
shef_bath <- gsub("Bathroom","Bath",shef_bath)
shef_bath <- gsub("Baths","Bath",shef_bath)
shef_bath <- gsub("Bathrooms","Bath",shef_bath)
shef_bath <- gsub("\r\n","",shef_bath)
shef_bath <- gsub(" ","",shef_bath)
shef_bath <- substring(shef_bath,1,1)
# head(shef_bath)

shef_sqft <- gsub(" ","",shef_sqft)
shef_sqft[grep("-",shef_sqft)] <- substring(shef_sqft[grep("-",shef_sqft)],1,regexpr("-",shef_sqft[grep("-",shef_sqft)])-1)
shef_sqft <- gsub("SqFt","",shef_sqft)
# head(shef_sqft)

shef_avail <- gsub("\r\n","",shef_avail)
shef_avail <- gsub(" ","",shef_avail)
shef_avail <- gsub("AvailableNow","Now",shef_avail)
# head(shef_avail)


# Grab only 1bd info
shef_fp_1bd <- shef_fp[which(shef_bed=="1")]
shef_rent_1bd <- shef_rent[which(shef_bed=="1")]
shef_bed_1bd <- shef_bed[which(shef_bed=="1")]
shef_bath_1bd <- shef_bath[which(shef_bed=="1")]
shef_sqft_1bd <- shef_sqft[which(shef_bed=="1")]
shef_avail_1bd <- shef_avail[which(shef_bed=="1")]

# Grab available apts
shef_fp_1bd <- shef_fp_1bd[which(shef_avail_1bd!="NotAvailable")]
shef_rent_1bd <- shef_rent_1bd[which(shef_avail_1bd!="NotAvailable")]
shef_bed_1bd <- shef_bed_1bd[which(shef_avail_1bd!="NotAvailable")]
shef_bath_1bd <- shef_bath_1bd[which(shef_avail_1bd!="NotAvailable")]
shef_sqft_1bd <- shef_sqft_1bd[which(shef_avail_1bd!="NotAvailable")]
shef_avail_1bd <- shef_avail_1bd[which(shef_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(shef_fp_1bd)
apt <- rep("Sheffield Court",num_apt)
shef_1bd <- data.frame(apt,shef_fp_1bd,shef_rent_1bd,shef_bed_1bd,shef_bath_1bd,
                       shef_sqft_1bd,shef_avail_1bd)
colnames(shef_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                        "AVAILABILITY")
# shef_1bd

# Remove duplicates
shef_1bd <- unique(shef_1bd)
# shef_1bd

# Grab cheapest floor plan
shef_low <- shef_1bd[which.min(shef_1bd$RENT),]
# shef_low

# Grab floor plans available in sep
shef_sep <- shef_1bd[grep("Sep",shef_1bd$AVAILABILITY),]
# shef_sep

##################################
### AVALON AT ARLINGTON SQUARE ###
##################################

# Store URL to be scraped
ava_url <- 'https://www.apartments.com/avalon-at-arlington-square-arlington-va/321zmzg/'

# Read HTML from URL
ava_webpage <- read_html(ava_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
ava_fp_html <- html_nodes(ava_webpage,'.name')
ava_rent_html <- html_nodes(ava_webpage,'.rent')
ava_bed_html <- html_nodes(ava_webpage,'.beds')
ava_bath_html <- html_nodes(ava_webpage,'.baths')
ava_sqft_html <- html_nodes(ava_webpage,'.sqft')
ava_avail_html <- html_nodes(ava_webpage,'.available')

# Convert data to text
ava_fp <- html_text(ava_fp_html)
ava_rent <- html_text(ava_rent_html)
ava_bed <- html_text(ava_bed_html)
ava_bath <- html_text(ava_bath_html)
ava_sqft <- html_text(ava_sqft_html)
ava_avail <- html_text(ava_avail_html)

# Quick look at data
# head(ava_rent)
# head(ava_bed)
# head(ava_bath)
# head(ava_fp)
# head(ava_sqft)
# head(ava_avail)

# Data Cleanup
ava_rent <- gsub("\r\n","",ava_rent)
ava_rent <- gsub(" ","",ava_rent)
ava_rent <- substring(ava_rent,1,6)
# head(ava_rent)

ava_bed <- ava_bed[grep("[&-]",ava_bed)*-1]
ava_bed <- gsub("BR","Bed",ava_bed)
ava_bed <- gsub("Bedroom","Bed",ava_bed)
ava_bed <- gsub("Beds","Bed",ava_bed)
ava_bed <- gsub("Studio","0Bed",ava_bed)
ava_bed <- gsub("\r\n","",ava_bed)
ava_bed <- gsub(" ","",ava_bed)
ava_bed <- substring(ava_bed,1,1)
# head(ava_bed)

ava_bath <- gsub("BA","Bath",ava_bath)
ava_bath <- gsub("Bathroom","Bath",ava_bath)
ava_bath <- gsub("Baths","Bath",ava_bath)
ava_bath <- gsub("Bathrooms","Bath",ava_bath)
ava_bath <- gsub("\r\n","",ava_bath)
ava_bath <- gsub(" ","",ava_bath)
ava_bath <- substring(ava_bath,1,1)
# head(ava_bath)

ava_sqft <- gsub(" ","",ava_sqft)
ava_sqft[grep("-",ava_sqft)] <- substring(ava_sqft[grep("-",ava_sqft)],1,regexpr("-",ava_sqft[grep("-",ava_sqft)])-1)
ava_sqft <- gsub("SqFt","",ava_sqft)
# head(ava_sqft)

ava_avail <- gsub("\r\n","",ava_avail)
ava_avail <- gsub(" ","",ava_avail)
ava_avail <- gsub("AvailableNow","Now",ava_avail)
# head(ava_avail)


# Grab only 1bd info
ava_fp_1bd <- ava_fp[which(ava_bed=="1")]
ava_rent_1bd <- ava_rent[which(ava_bed=="1")]
ava_bed_1bd <- ava_bed[which(ava_bed=="1")]
ava_bath_1bd <- ava_bath[which(ava_bed=="1")]
ava_sqft_1bd <- ava_sqft[which(ava_bed=="1")]
ava_avail_1bd <- ava_avail[which(ava_bed=="1")]

# Grab available apts
ava_fp_1bd <- ava_fp_1bd[which(ava_avail_1bd!="NotAvailable")]
ava_rent_1bd <- ava_rent_1bd[which(ava_avail_1bd!="NotAvailable")]
ava_bed_1bd <- ava_bed_1bd[which(ava_avail_1bd!="NotAvailable")]
ava_bath_1bd <- ava_bath_1bd[which(ava_avail_1bd!="NotAvailable")]
ava_sqft_1bd <- ava_sqft_1bd[which(ava_avail_1bd!="NotAvailable")]
ava_avail_1bd <- ava_avail_1bd[which(ava_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(ava_fp_1bd)
apt <- rep("Avalon",num_apt)
ava_1bd <- data.frame(apt,ava_fp_1bd,ava_rent_1bd,ava_bed_1bd,ava_bath_1bd,
                       ava_sqft_1bd,ava_avail_1bd)
colnames(ava_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                        "AVAILABILITY")
# ava_1bd

# Remove duplicates
ava_1bd <- unique(ava_1bd)
# ava_1bd

# Grab cheapest floor plan
ava_low <- ava_1bd[which.min(ava_1bd$RENT),]
# ava_low

# Grab floor plans available in sep
ava_sep <- ava_1bd[grep("Sep",ava_1bd$AVAILABILITY),]
# ava_sep

#####################
### CAMERON COURT ###
#####################

# Store URL to be scraped
cam_url <- 'https://www.apartments.com/cameron-court-alexandria-va/mcv28xj/'

# Read HTML from URL
cam_webpage <- read_html(cam_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
cam_fp_html <- html_nodes(cam_webpage,'.name')
cam_rent_html <- html_nodes(cam_webpage,'.rent')
cam_bed_html <- html_nodes(cam_webpage,'.beds')
cam_bath_html <- html_nodes(cam_webpage,'.baths')
cam_sqft_html <- html_nodes(cam_webpage,'.sqft')
cam_avail_html <- html_nodes(cam_webpage,'.available')

# Convert data to text
cam_fp <- html_text(cam_fp_html)
cam_rent <- html_text(cam_rent_html)
cam_bed <- html_text(cam_bed_html)
cam_bath <- html_text(cam_bath_html)
cam_sqft <- html_text(cam_sqft_html)
cam_avail <- html_text(cam_avail_html)

# Quick look at data
# head(cam_rent)
# head(cam_bed)
# head(cam_bath)
# head(cam_fp)
# head(cam_sqft)
# head(cam_avail)

# Data Cleanup
cam_rent <- gsub("\r\n","",cam_rent)
cam_rent <- gsub(" ","",cam_rent)
cam_rent <- substring(cam_rent,1,6)
# head(cam_rent)

cam_bed <- cam_bed[grep("[&-]",cam_bed)*-1]
cam_bed <- gsub("BR","Bed",cam_bed)
cam_bed <- gsub("Bedroom","Bed",cam_bed)
cam_bed <- gsub("Beds","Bed",cam_bed)
cam_bed <- gsub("Studio","0Bed",cam_bed)
cam_bed <- gsub("\r\n","",cam_bed)
cam_bed <- gsub(" ","",cam_bed)
cam_bed <- substring(cam_bed,1,1)
# head(cam_bed)

cam_bath <- gsub("BA","Bath",cam_bath)
cam_bath <- gsub("Bathroom","Bath",cam_bath)
cam_bath <- gsub("Baths","Bath",cam_bath)
cam_bath <- gsub("Bathrooms","Bath",cam_bath)
cam_bath <- gsub("\r\n","",cam_bath)
cam_bath <- gsub(" ","",cam_bath)
cam_bath <- substring(cam_bath,1,1)
# head(cam_bath)

cam_sqft <- gsub(" ","",cam_sqft)
cam_sqft[grep("-",cam_sqft)] <- substring(cam_sqft[grep("-",cam_sqft)],1,regexpr("-",cam_sqft[grep("-",cam_sqft)])-1)
cam_sqft <- gsub("SqFt","",cam_sqft)
# head(cam_sqft)

cam_avail <- gsub("\r\n","",cam_avail)
cam_avail <- gsub(" ","",cam_avail)
cam_avail <- gsub("AvailableNow","Now",cam_avail)
# head(cam_avail)


# Grab only 1bd info
cam_fp_1bd <- cam_fp[which(cam_bed=="1")]
cam_rent_1bd <- cam_rent[which(cam_bed=="1")]
cam_bed_1bd <- cam_bed[which(cam_bed=="1")]
cam_bath_1bd <- cam_bath[which(cam_bed=="1")]
cam_sqft_1bd <- cam_sqft[which(cam_bed=="1")]
cam_avail_1bd <- cam_avail[which(cam_bed=="1")]

# Grab available apts
cam_fp_1bd <- cam_fp_1bd[which(cam_avail_1bd!="NotAvailable")]
cam_rent_1bd <- cam_rent_1bd[which(cam_avail_1bd!="NotAvailable")]
cam_bed_1bd <- cam_bed_1bd[which(cam_avail_1bd!="NotAvailable")]
cam_bath_1bd <- cam_bath_1bd[which(cam_avail_1bd!="NotAvailable")]
cam_sqft_1bd <- cam_sqft_1bd[which(cam_avail_1bd!="NotAvailable")]
cam_avail_1bd <- cam_avail_1bd[which(cam_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(cam_fp_1bd)
apt <- rep("Cameron Court",num_apt)
cam_1bd <- data.frame(apt,cam_fp_1bd,cam_rent_1bd,cam_bed_1bd,cam_bath_1bd,
                      cam_sqft_1bd,cam_avail_1bd)
colnames(cam_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# cam_1bd

# Remove duplicates
cam_1bd <- unique(cam_1bd)
# cam_1bd

# Grab cheapest floor plan
cam_low <- cam_1bd[which.min(cam_1bd$RENT),]
# cam_low

# Grab floor plans available in sep
cam_sep <- cam_1bd[grep("Sep",cam_1bd$AVAILABILITY),]
# cam_sep

###########################
### LINCOLN AT OLD TOWN ###
###########################

# Store URL to be scraped
linc_url <- 'https://www.apartments.com/lincoln-old-town-alexandria-va/p9xlw6r/'

# Read HTML from URL
linc_webpage <- read_html(linc_url)

# Use CSS selectors to scrape apt info
# Use the Chrome extension 'SelectorGadget' to help find CSS selectors
linc_fp_html <- html_nodes(linc_webpage,'.name')
linc_rent_html <- html_nodes(linc_webpage,'.rent')
linc_bed_html <- html_nodes(linc_webpage,'.beds')
linc_bath_html <- html_nodes(linc_webpage,'.baths')
linc_sqft_html <- html_nodes(linc_webpage,'.sqft')
linc_avail_html <- html_nodes(linc_webpage,'.available')

# Convert data to text
linc_fp <- html_text(linc_fp_html)
linc_rent <- html_text(linc_rent_html)
linc_bed <- html_text(linc_bed_html)
linc_bath <- html_text(linc_bath_html)
linc_sqft <- html_text(linc_sqft_html)
linc_avail <- html_text(linc_avail_html)

# Quick look at data
# head(linc_rent)
# head(linc_bed)
# head(linc_bath)
# head(linc_fp)
# head(linc_sqft)
# head(linc_avail)

# Data Cleanup
linc_rent <- gsub("\r\n","",linc_rent)
linc_rent <- gsub(" ","",linc_rent)
linc_rent <- substring(linc_rent,1,6)
# head(linc_rent)

linc_bed <- linc_bed[grep("[&-]",linc_bed)*-1]
linc_bed <- gsub("BR","Bed",linc_bed)
linc_bed <- gsub("Bedroom","Bed",linc_bed)
linc_bed <- gsub("Beds","Bed",linc_bed)
linc_bed <- gsub("Studio","0Bed",linc_bed)
linc_bed <- gsub("\r\n","",linc_bed)
linc_bed <- gsub(" ","",linc_bed)
linc_bed <- substring(linc_bed,1,1)
# head(linc_bed)

linc_bath <- gsub("BA","Bath",linc_bath)
linc_bath <- gsub("Bathroom","Bath",linc_bath)
linc_bath <- gsub("Baths","Bath",linc_bath)
linc_bath <- gsub("Bathrooms","Bath",linc_bath)
linc_bath <- gsub("\r\n","",linc_bath)
linc_bath <- gsub(" ","",linc_bath)
linc_bath <- substring(linc_bath,1,1)
# head(linc_bath)

linc_sqft <- gsub(" ","",linc_sqft)
linc_sqft[grep("-",linc_sqft)] <- substring(linc_sqft[grep("-",linc_sqft)],1,regexpr("-",linc_sqft[grep("-",linc_sqft)])-1)
linc_sqft <- gsub("SqFt","",linc_sqft)
# head(linc_sqft)

linc_avail <- gsub("\r\n","",linc_avail)
linc_avail <- gsub(" ","",linc_avail)
linc_avail <- gsub("AvailableNow","Now",linc_avail)
# head(linc_avail)


# Grab only 1bd info
linc_fp_1bd <- linc_fp[which(linc_bed=="1")]
linc_rent_1bd <- linc_rent[which(linc_bed=="1")]
linc_bed_1bd <- linc_bed[which(linc_bed=="1")]
linc_bath_1bd <- linc_bath[which(linc_bed=="1")]
linc_sqft_1bd <- linc_sqft[which(linc_bed=="1")]
linc_avail_1bd <- linc_avail[which(linc_bed=="1")]

# Grab available apts
linc_fp_1bd <- linc_fp_1bd[which(linc_avail_1bd!="NotAvailable")]
linc_rent_1bd <- linc_rent_1bd[which(linc_avail_1bd!="NotAvailable")]
linc_bed_1bd <- linc_bed_1bd[which(linc_avail_1bd!="NotAvailable")]
linc_bath_1bd <- linc_bath_1bd[which(linc_avail_1bd!="NotAvailable")]
linc_sqft_1bd <- linc_sqft_1bd[which(linc_avail_1bd!="NotAvailable")]
linc_avail_1bd <- linc_avail_1bd[which(linc_avail_1bd!="NotAvailable")]

# Combine 1bd vectors in data frame
num_apt <- length(linc_fp_1bd)
apt <- rep("Lincoln at Old Town",num_apt)
linc_1bd <- data.frame(apt,linc_fp_1bd,linc_rent_1bd,linc_bed_1bd,linc_bath_1bd,
                      linc_sqft_1bd,linc_avail_1bd)
colnames(linc_1bd) <- c("APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# linc_1bd

# Remove duplicates
linc_1bd <- unique(linc_1bd)
# linc_1bd

# Grab cheapest floor plan
linc_low <- linc_1bd[which.min(linc_1bd$RENT),]
# linc_low

# Grab floor plans available in sep
linc_sep <- linc_1bd[grep("Sep",linc_1bd$AVAILABILITY),]
# linc_sep

#-------------------------------- REPORT --------------------------------#

###########################
### COMBINE DATA FRAMES ###
###########################

# Combine all possible apts
allapt <- rbind(mer_1bd,cmill_1bd,c800_1bd,cplace_1bd,cas_1bd,res_1bd,brad_1bd,shef_1bd,ava_1bd,
                cam_1bd,linc_1bd)
rownames(allapt) <- seq(length=nrow(allapt))
# allapt

# Sort by ascending rent
attach(allapt)
allapt_sort <- allapt[order(allapt$RENT),]
detach(allapt)

# Combine all cheapest for each apt
allapt_low <- rbind(mer_low,cmill_low,c800_low,cplace_low,cas_low,res_low,brad_low,shef_low,ava_low,
                    cam_low,linc_low)
rownames(allapt_low) <- seq(length=nrow(allapt_low))
# allapt_low

# Combine all sep availabilities for each apt
allapt_sep <- rbind(mer_sep,cmill_sep,c800_sep,cplace_sep,cas_sep,res_sep,brad_sep,shef_sep,ava_sep,
                    cam_sep,linc_sep)
rownames(allapt_sep) <- seq(length=nrow(allapt_sep))
# allapt_sep


####################
### EMAIL REPORT ###
####################

#Check if gmailr and tableHTML packages are installed and if not, install it
if(!require(gmailr)){
  install.packages("gmailr")
}
if(!require(tableHTML)){
  install.packages("tableHTML")
}

# Load gmailr and tableHTML packages
library(gmailr)
library(tableHTML)

# Create HTML tables
#allmsg = tableHTML(allapt_sort)
lowmsg = tableHTML(allapt_low)
sepmsg = tableHTML(allapt_sep)

# Add a paragraph before each table
# html_bod <- paste0("<p> All available 1BD apartments (sorted by rent low to high) </p>",allmsg,
#                    "<p> Cheapest floor plan for each apartment </p>",lowmsg,
#                    "<p> Floor plans available in September </p>", sepmsg)
html_bod <- paste0("<p> Cheapest floor plan for each apartment </p>",lowmsg,
                   "<p> Floor plans available in September </p>", sepmsg)
# gm_auth_configure(key = "824009897553-gdokapa979sp3nmcqf0qa72b7ieqhd17.apps.googleusercontent.com",
#                   secret = "asWzDaMBRBNrDr9QShqxHLGM"
#                   )
options(httr_oob_default=TRUE)
gm_auth_configure(key = "824009897553-jh5de5r7n0e4948drm30nu966grt5hi2.apps.googleusercontent.com",
                  secret = "8UyZYWxIEVAduQRYr8Wya9uD",
                  path = "C:/Users/pseng/Documents/R/gmailcred_new.json"
)

# Authorize R to write/read emails (only have to do once)
gm_auth(email = "notify.pavina@gmail.com")

# Creat a MIME message and send it
gm_mime() %>%
  gm_to("psengkhyavong@gmail.com") %>%
  gm_from("notify.pavina@gmail.com") %>%
  gm_subject("Apt Listings") %>%
  gm_html_body(html_bod) %>%
  gm_send_message()

####################
### COLLECT DATA ###
####################

# Add today's date to data frame
today <- Sys.Date()
num_rows <- nrow(allapt)
today_df <- rep(today,num_rows)
aptdata <- data.frame(today_df,allapt_sort)
colnames(aptdata) <- c("DATE","APT","FLOORPLAN","RENT","BED","BATH","SQFT",
                       "AVAILABILITY")
# aptdata

# Append to CSV
# write.table( aptdata,
#              file="C:/Users/pseng/Documents/Apt CSV/apt_daily_data_1bd.csv",
#              append = T,
#              sep=',',
#              row.names=F,
#              col.names=F )

# Append to Google Sheets
if(!require(googlesheets)){
  install.packages("googlesheets")
}

library(googlesheets)

gs_auth(key = "824009897553-jh5de5r7n0e4948drm30nu966grt5hi2.apps.googleusercontent.com",
        secret = "8UyZYWxIEVAduQRYr8Wya9uD" 
)

mykey <- "1gBzWMdvlhQGt7O3QZpBEqsyvcYCrpnslC25Zpw5x3Bg"
gs_key(mykey)
mytitle <- gs_title("AptData")
gs_add_row(mytitle,ws=1,input = aptdata)

#-------------------------------- REFERENCES --------------------------------#

# To web scrape: 
# https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

# To send email: 
# https://stackoverflow.com/questions/50346367/gmailr-sending-data-frame-in-body-of-email

# To append to cSV:
# https://stackoverflow.com/questions/45930711/appending-a-new-line-into-an-existing-csv-file
