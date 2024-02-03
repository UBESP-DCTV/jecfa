is_tox_condition_satisfied <- function(tox_abbr) {
  is.na(tox_abbr) ||
    (tox_abbr %in% c("NOT A FAS")) ||
    (substr(tox_abbr, 1, 12) %in% c("NOT PREPARED"))
}
