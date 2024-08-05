#' JECFA Distiller Dataset
#'
#' This dataset contains information extracted from various JECFA reports and related sources. It includes details about toxicological monographs, specifications, and other relevant data points.
#'
#' @format A data frame with 7 rows and 36 variables:
#' \describe{
#'   \item{Report}{Character. Report identifier, e.g., "TRS 751-JECFA 30/18".}
#'   \item{Report_sourcelink}{Character. Link to the source of the report, e.g., "https://apps.who.int/iris/".}
#'   \item{Tox.Monograph}{Character. Identifier for the toxicological monograph, e.g., "FAS 21-JECFA 30/55".}
#'   \item{Tox.Monograph_sourcelink}{Character. Link to the toxicological monograph, e.g., "http://www.inchem.org/documents/".}
#'   \item{Specification}{Character. Specification details, e.g., "FAO Combined Compendium of Food Additive Specifications".}
#'   \item{Specification_sourcelink}{Character. Link to the specification source, e.g., "https://www.fao.org/food/food-safety-quality/".}
#'   \item{Synonyms}{Character. Synonyms for the chemical, e.g., "Vitamin E; RRR-Alpha-tocopherol".}
#'   \item{CAS.number}{Character. CAS number for the chemical, if available.}
#'   \item{Functional.Class}{Character. Functional class of the chemical, e.g., "Food AdditivesANTIOXIDANTNUTRIENT".}
#'   \item{Evaluation.year}{Character. Year of evaluation, e.g., "1986".}
#'   \item{Chemical.Names}{Character. Chemical names, e.g., "(2R,4',R,8'R)-2,5,7,8-Tetra".}
#'   \item{JECFA.number}{Character. JECFA number, if available.}
#'   \item{COE.number}{Character. COE number, if available.}
#'   \item{FEMA.number}{Character. FEMA number, if available.}
#'   \item{JECFA_name}{Character. Name used by JECFA, e.g., "(+)-alpha-TOCOPHEROL".}
#'   \item{URL}{Character. URL to additional resources or information.}
#'   \item{FAS}{Character. FAS identifier, e.g., "21".}
#'   \item{type}{Character. File type, e.g., ".htm", "html".}
#'   \item{host}{Character. Host of the document, e.g., "www.inchem.org".}
#'   \item{Tox_monograph_abbr}{Character. Abbreviation for the toxicological monograph, e.g., "FAS 21".}
#'   \item{Report_clean}{Character. Cleaned report identifier, e.g., "TRS 751-JECFA 30/18".}
#'   \item{ref_id}{Integer. Reference ID, e.g., 21.}
#'   \item{source}{Character. Source of the information, e.g., "FAS".}
#'   \item{file}{Character. File name, e.g., "21.pdf".}
#'   \item{dose-response}{Logical. Indicates if dose-response information is available.}
#'   \item{dose response}{Logical. Duplicate column indicating if dose-response information is available.}
#'   \item{modelling}{Logical. Indicates if modelling information is available.}
#'   \item{modeling}{Logical. Duplicate column indicating if modeling information is available.}
#'   \item{bmd}{Logical. Indicates if benchmark dose (BMD) information is available.}
#'   \item{bmr}{Logical. Indicates if benchmark response (BMR) information is available.}
#'   \item{benchmark dose}{Logical. Duplicate column indicating if benchmark dose information is available.}
#'   \item{benchmark-dose}{Logical. Duplicate column indicating if benchmark dose information is available.}
#'   \item{Chemical.Names_conc}{Character. Concatenated chemical names.}
#'   \item{URL_conc}{Character. Concatenated URLs.}
#'   \item{ref_distiller}{Integer. Reference distiller ID, e.g., 1.}
#'   \item{CAS.number_1}{Character. Additional CAS number information, if available.}
#' }
#' @source Extracted from JECFA reports and related sources.
#' @name jecfaDistiller
NULL


#' JECFA Toxicological Monographs Full Dataset
#'
#' This dataset includes detailed information extracted from various JECFA reports and toxicological monographs. It contains data on specifications, synonyms, CAS numbers, functional classes, and more.
#'
#' @format A data frame with 280 rows and 28 variables:
#' \describe{
#'   \item{Report}{Character. Report identifier, e.g., "TRS 776-JECFA 33/22".}
#'   \item{Report_sourcelink}{Character. Link to the source of the report, e.g., "https://apps.who.int/iris/".}
#'   \item{Tox.Monograph}{Character. Identifier for the toxicological monograph, e.g., "FAS 24-JECFA 33/97".}
#'   \item{Tox.Monograph_sourcelink}{Character. Link to the toxicological monograph, e.g., "http://www.inchem.org/documents/".}
#'   \item{Specification}{Character. Specification details, e.g., "FAO Combined Compendium of Food Additive Specifications".}
#'   \item{Specification_sourcelink}{Character. Link to the specification source, e.g., "https://www.fao.org/food/food-safety-quality/".}
#'   \item{Synonyms}{Character. Synonyms for the chemical, e.g., "Karaya; Gum sterculia; Sterculia urens".}
#'   \item{CAS.number}{Character. CAS number for the chemical, e.g., "9000-36-6".}
#'   \item{Functional.Class}{Character. Functional class of the chemical, e.g., "Food AdditivesEMULSIFIERSTABILIZER".}
#'   \item{Evaluation.year}{Character. Year of evaluation, e.g., "1988".}
#'   \item{Chemical.Names}{Character. Chemical names, if available.}
#'   \item{JECFA.number}{Character. JECFA number, if available.}
#'   \item{COE.number}{Character. COE number, if available.}
#'   \item{FEMA.number}{Character. FEMA number, if available.}
#'   \item{JECFA_name}{Character. Name used by JECFA, e.g., "KARAYA GUM".}
#'   \item{URL}{Character. URL to additional resources or information.}
#'   \item{FAS}{Character. FAS identifier, e.g., "24".}
#'   \item{type}{Character. File type, e.g., ".htm".}
#'   \item{host}{Character. Host of the document, e.g., "www.inchem.org".}
#'   \item{Tox_monograph_abbr}{Character. Abbreviation for the toxicological monograph, e.g., "FAS 24".}
#'   \item{Report_clean}{Character. Cleaned report identifier, e.g., "TRS 776-JECFA 33/22".}
#'   \item{ref_id}{Integer. Reference ID, e.g., 1.}
#'   \item{source}{Character. Source of the information, e.g., "FAS".}
#'   \item{file}{Character. File name, e.g., "24.pdf".}
#'   \item{keywords}{Character. Keywords related to the toxicological information, e.g., "dose-response".}
#'   \item{matching_pages}{List. Pages in the document that match the keywords.}
#'   \item{keyword_match}{Logical. Indicates if there is a keyword match in the document.}
#'   \item{any_match}{Logical. Indicates if there is any match in the document.}
#' }
#' @source Extracted from JECFA reports and related sources.
#' @name jecfa_tm_full
NULL




#' JECFA Augmented Dataset
#'
#' This dataset includes comprehensive information extracted from various JECFA reports and related sources. It contains detailed data on toxicological monographs, specifications, synonyms, CAS numbers, functional classes, and more.
#'
#' @format A data frame with 6,560 rows and 22 variables:
#' \describe{
#'   \item{Report}{Character. Report identifier, e.g., "TRS 776-JECFA 33/22".}
#'   \item{Report_sourcelink}{Character. Link to the source of the report, e.g., "http://apps.who.int/iris/".}
#'   \item{Tox.Monograph}{Character. Identifier for the toxicological monograph, e.g., "FAS 24-JECFA 33/97".}
#'   \item{Tox.Monograph_sourcelink}{Character. Link to the toxicological monograph, e.g., "http://www.inchem.org/documents/".}
#'   \item{Specification}{Character. Specification details, e.g., "FAO Combined Compendium of Food Additive Specifications".}
#'   \item{Specification_sourcelink}{Character. Link to the specification source, e.g., "https://www.fao.org/food/food-safety-quality/".}
#'   \item{Synonyms}{Character. Synonyms for the chemical, e.g., "Karaya; Gum sterculia; Sterculia urens".}
#'   \item{CAS.number}{Character. CAS number for the chemical, e.g., "9000-36-6".}
#'   \item{Functional.Class}{Character. Functional class of the chemical, e.g., "Food AdditivesEMULSIFIERSTABILIZER".}
#'   \item{Evaluation.year}{Character. Year of evaluation, e.g., "1988".}
#'   \item{Chemical.Names}{Character. Chemical names, if available.}
#'   \item{JECFA.number}{Character. JECFA number, if available.}
#'   \item{COE.number}{Character. COE number, if available.}
#'   \item{FEMA.number}{Character. FEMA number, if available.}
#'   \item{JECFA_name}{Character. Name used by JECFA, e.g., "KARAYA GUM".}
#'   \item{URL}{Character. URL to additional resources or information.}
#'   \item{FAS}{Character. FAS identifier, e.g., "24".}
#'   \item{type}{Character. File type, e.g., ".htm".}
#'   \item{host}{Character. Host of the document, e.g., "www.inchem.org".}
#'   \item{Tox_monograph_abbr}{Character. Abbreviation for the toxicological monograph, e.g., "FAS 24".}
#'   \item{Report_clean}{Character. Cleaned report identifier, e.g., "TRS 776-JECFA 33/22".}
#'   \item{ref_id}{Integer. Reference ID, e.g., 1.}
#' }
#' @source Extracted from JECFA reports and related sources.
#' @name jecfa_augmented
NULL



#' JECFA Dataset
#'
#' This dataset contains comprehensive information extracted from various JECFA reports and related sources. It includes data on toxicological monographs, specifications, synonyms, CAS numbers, functional classes, and more.
#'
#' @format A data frame with 6,560 rows and 17 variables:
#' \describe{
#'   \item{Report}{Character. Report identifier, e.g., "TRS 776-JECFA 33/22".}
#'   \item{Report_sourcelink}{Character. Link to the source of the report, e.g., "http://apps.who.int/iris/".}
#'   \item{Tox.Monograph}{Character. Identifier for the toxicological monograph, e.g., "FAS 24-JECFA 33/97".}
#'   \item{Tox.Monograph_sourcelink}{Character. Link to the toxicological monograph, e.g., "http://www.inchem.org/documents/".}
#'   \item{Specification}{Character. Specification details, e.g., "FAO Combined Compendium of Food Additive Specifications".}
#'   \item{Specification_sourcelink}{Character. Link to the specification source, e.g., "https://www.fao.org/food/food-safety-quality/".}
#'   \item{Synonyms}{Character. Synonyms for the chemical, e.g., "Karaya; Gum sterculia; Sterculia urens".}
#'   \item{CAS.number}{Character. CAS number for the chemical, e.g., "9000-36-6".}
#'   \item{Functional.Class}{Character. Functional class of the chemical, e.g., "Food AdditivesEMULSIFIERSTABILIZER".}
#'   \item{Evaluation.year}{Character. Year of evaluation, e.g., "1988".}
#'   \item{Chemical.Names}{Character. Chemical names, if available.}
#'   \item{JECFA.number}{Character. JECFA number, if available.}
#'   \item{COE.number}{Character. COE number, if available.}
#'   \item{FEMA.number}{Character. FEMA number, if available.}
#'   \item{JECFA_name}{Character. Name used by JECFA, e.g., "KARAYA GUM".}
#'   \item{URL}{Character. URL to additional resources or information.}
#'   \item{FAS}{Character. FAS identifier, e.g., "24".}
#' }
#' @source Extracted from JECFA reports and related sources.
#' @name jecfa
NULL

