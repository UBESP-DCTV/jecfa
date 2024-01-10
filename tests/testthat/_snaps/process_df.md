# process_df works

    structure(list(Report = c("TRS 776-JECFA 33/22", "TRS 909-JECFA 57/61", 
    "TRS 913-JECFA 59/111", "TRS 913-JECFA 59/41", "TRS 913-JECFA 59/102", 
    "TRS 913-JECFA 59/65", "TRS 947-JECFA68/"), Report_sourcelink = c("https://apps.who.int/iris/bitstream/10665/39252/1/WHO_TRS_776.pdf", 
    "https://apps.who.int/iris/bitstream/10665/42578/1/WHO_TRS_909.pdf", 
    "https://apps.who.int/iris/bitstream/10665/42601/1/WHO_TRS_913.pdf", 
    "https://apps.who.int/iris/bitstream/10665/42601/1/WHO_TRS_913.pdf", 
    "https://apps.who.int/iris/bitstream/10665/42601/1/WHO_TRS_913.pdf", 
    "https://apps.who.int/iris/bitstream/10665/42601/1/WHO_TRS_913.pdf", 
    "https://apps.who.int/iris/bitstream/10665/43870/1/9789241209472_eng.pdf"
    ), Tox.Monograph = c("FAS 24-JECFA 33/97", "FAS 48-JECFA 57/117", 
    "FAS 40-JECFA 49/267 (1997)", "FAS 50-JECFA 59/173", "FAS 50-JECFA 59/371", 
    "FAS 50-JECFA 59/265", "FAS 59-JECFA68/"), Tox.Monograph_sourcelink = c("http://www.inchem.org/documents/jecfa/jecmono/v024je06.htm", 
    "http://www.inchem.org/pages/jecfa.html", "http://www.inchem.org/pages/jecfa.html", 
    "http://www.inchem.org/pages/jecfa.html", "http://www.inchem.org/pages/jecfa.html", 
    "http://www.inchem.org/pages/jecfa.html", "https://apps.who.int/iris/bitstream/10665/43823/1/9789241660594_eng.pdf"
    ), Specification = c("FAO Combined Compendium of Food Additive Specifications", 
    "Compendium of FAO food additive specifications", "COMPENDIUM ADDENDUM 11/FNP 52 Add.11/95 (2003)", 
    "COMPENDIUM ADDENDUM 10/FNP 52 Add.10/50", "COMPENDIUM ADDENDUM 10/FNP 52 Add.10/74", 
    "COMPENDIUM ADDENDUM 10/FNP 52 Add.10/62", "FAO Combined Compendium of Food Additive Specifications"
    ), Specification_sourcelink = c("https://www.fao.org/food/food-safety-quality/scientific-advice/jecfa/jecfa-additives/en/", 
    "https://www.fao.org/food/food-safety-quality/scientific-advice/jecfa/jecfa-flav/en/", 
    "http://www.fao.org/ag/agn/jecfa-additives/search.html", "http://www.fao.org/ag/agn/jecfa-additives/search.html", 
    "http://www.fao.org/ag/agn/jecfa-additives/search.html", "http://www.fao.org/ag/agn/jecfa-additives/search.html", 
    "https://www.fao.org/food/food-safety-quality/scientific-advice/jecfa/jecfa-additives/en/ "
    ), Synonyms = c("Karaya; Gum sterculia; Sterculia; Kadaya; Katilo; Kullo; Kuterra; Gum karaya", 
    "1-p-Tolylethanol;p-Tolyl methyl carbinol;Methyl p-tolyl carbinol", 
    NA, "ETHYL 3-CYCLOHEXYLPROPANOATE; ETHYL CYCLOHEXYLPROPIONATE; ETHYL HEXAHYDROPHENYL PROPIONATE", 
    "ETHYLIDENE ACETONE; METHYL PROPENYL KETONE", NA, "Ferric sodium edetate; Sodium iron EDTA; Sodium feredetate"
    ), CAS.number = c("9000-36-6", NA, "2445-78-5", NA, NA, NA, "15708-41-5"
    ), Functional.Class = c("Food AdditivesEMULSIFIERSTABILIZERTHICKENER", 
    "Flavouring AgentFLAVOURING_AGENT", "Flavouring AgentFLAVOURING_AGENT", 
    "Flavouring AgentFLAVOURING_AGENT", "Flavouring AgentFLAVOURING_AGENT", 
    "Flavouring AgentFLAVOURING_AGENT", "Food AdditivesNUTRIENT_SUPPLEMENT"
    ), Evaluation.year = c("1988", "2001", "2002", "2002", "2002", 
    "2002", "2007"), Chemical.Names = c(NA, "1-(4-Methylphenyl)ethanol", 
    "2-Methylbutyl 2-methylbutanoate", "ETHYL CYCLOHEXANEPROPIONATE", 
    "PENT-3-EN-2-ONE", "2-Ethyl-4-methylthiazole", "Sodium [[N,N'-ethanediylbis[N-(carboxymethyl)glycinato]](4-]ferrate(1-); Sodium iron (III) ethylenediaminetetraacetate"
    ), JECFA.number = c(NA, "805", "212", "966", "1124", "1044", 
    NA), COE.number = c(NA, "10197", "10773", "2095", "666", "11612", 
    NA), FEMA.number = c(NA, "3139", "3359", "2431", "3417", "3680", 
    NA), JECFA_name = c("KARAYA GUM", "p,alpha-DIMETHYLBENZYL ALCOHOL", 
    "2-METHYLBUTYL 2-METHYLBUTYRATE", "ETHYL HEXAHYDROPHENYL PROPIONATE", 
    "ETHYLIDENE ACETONE", "2-ETHYL-4-METHYLTHIAZOLE", "SODIUM FEREDETATE"
    ), URL = c("https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/1", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/2", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/3", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/4", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/5", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/6", 
    "https://apps.who.int/food-additives-contaminants-jecfa-database/Home/Chemical/7"
    ), FAS = c("24", "48", "40", "50", "50", "50", "59")), row.names = c(NA, 
    -7L), class = c("tbl_df", "tbl", "data.frame"))

