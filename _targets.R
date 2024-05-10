library(targets)
library(tarchetypes)
library(here)
library(crew)

tar_option_set(
  packages = c("tibble"),
  format = "qs",
  error = "continue",
  controller = crew_controller_local(
    workers = 2
  ),
  storage = "worker",
  retrieval = "worker"
)

tar_source()

# Targets ---------------------
list(
  tar_target(
    name = jecfa_ids,
    command = seq_len(10000)
  ),

  tar_target(
    name = jecfa_list,
    command = compose_jecfa_list(jecfa_ids),
    pattern = map(jecfa_ids),
    iteration = "list",
    cue = tar_cue("always")
  ),

  tar_target(
    name = jecfa_kos,
    command = get_error(jecfa_list),
    pattern = map(jecfa_list),
    iteration = "list"
  ),

  tar_target(
    name = jecfa_oks,
    command = get_result(jecfa_list),
    pattern = map(jecfa_list),
    iteration = "list"
  ),


  tar_target(
    name = jecfa_raw,
    command = create_df(jecfa_oks)
  ),
  tar_target(
    name = jecfa,
    command = process_df(jecfa_raw)
  ),
  tar_target(
    name = jecfa_augmented,
    command = add_metadata(jecfa)
  )

  # # Tables ----------------------
  # tar_target(
  #   name = tbl1,
  #   command = compose_tbl1(jecfa_augmented)
  # ),
  # tar_target(
  #   name = tbl2,
  #   command = compose_tbl2(jecfa_augmented)
  # ),
  # tar_target(
  #   name = tbl3,
  #   command = compose_tbl3(jecfa_augmented)
  # ),
  # tar_target(
  #   name = tbl4,
  #   command = compose_tbl4(jecfa_augmented)
  # ),
  #
  #
  # # TRS -------------------------
  # tar_target(
  #   urls_list,
  #   command = compose_urls(jecfa_augmented)
  # ),
  #
  # tar_target(
  #   urls_ok,
  #   command = remove_null_urls(urls_list)
  # ),
  #
  # tar_target(
  #   trsPaths,
  #   compose_filepaths(
  #     urls_ok,
  #     here::here("data/TRS")
  #   )
  # ),
  #
  # tar_target(
  #   trsMapToJecfa,
  #   compose_maptojecfa(trsPaths)
  # ),
  #
  # tar_files(
  #   fasPaths,
  #   list.files(
  #       here::here("data/FAS"),
  #       pattern = "\\.pdf$",
  #       full.names = TRUE
  #   )
  # ),
  # tar_target(
  #   fasMapToJecfa,
  #   jecfa_augmented |>
  #     dplyr::mutate(
  #       file = FAS |>
  #         stringr::str_extract("^\\d+") |>
  #         stringr::str_c(".pdf")
  #     ) |>
  #     dplyr::select(file, ref_id)
  # ),
  #
  # tar_target(
  #   trsPathsNoid,
  #   compose_filepaths(
  #     urls_ok,
  #     here::here("data/TRS_unique"),
  #     noid = TRUE
  #   )
  # ),
  #
  # tar_target(
  #   trsUrls,
  #   command = purrr::map_chr(urls_ok, "url"),
  #   format = "url"
  # ),
  #
  # tar_target(
  #   trsDownload,
  #   download_trs(
  #     trsUrls, trsPaths, trsPathsNoid
  #   ),
  #   pattern = map(
  #     trsUrls, trsPaths, trsPathsNoid
  #   ),
  #   format = "file"
  # ),
  #
  # tar_target(
  #   trsUniqueAux,
  #   unique(trsDownload)
  # ),
  #
  # tar_target(
  #   trsUnique,
  #   trsUniqueAux,
  #   pattern = map(trsUniqueAux),
  #   format = "file"
  # ),
  #
  #
  # tar_target(
  #   trsParsed,
  #   parse_pdf(trsUnique, dpi = 75),
  #   pattern = map(trsUnique),
  #   iteration = "list"
  # ),
  #
  # tar_target(
  #   fasParsed,
  #   parse_pdf(fasPaths, dpi = 75),
  #   pattern = map(fasPaths),
  #   iteration = "list"
  # ),
  #
  # tar_target(
  #   keywords,
  #   c(
  #     "dose-response",
  #     "dose response",
  #     "modelling",
  #     "modeling",
  #     "bmd",
  #     "bmr",
  #     "benchmark dose",
  #     "benchmark-dose"
  #   )
  # ),
  #
  # tar_target(
  #   FASKeywordMatching,
  #   match_keywords(
  #     fasPaths, fasParsed, keywords, "FAS"
  #   ) |>
  #     dplyr::left_join(
  #       fasMapToJecfa,
  #       relationship = "many-to-many"
  #     ),
  #   pattern = map(fasPaths, fasParsed)
  # ),
  #
  # tar_target(
  #   TRSKeywordMatching,
  #   match_keywords(
  #     trsUnique, trsParsed, keywords, "TRS"
  #   ) |>
  #     dplyr::left_join(
  #       trsMapToJecfa,
  #       relationship = "many-to-many"
  #     ),
  #   pattern = map(trsUnique, trsParsed)
  # ),
  #
  # tar_target(
  #   keywordMatching,
  #   FASKeywordMatching |>
  #     dplyr::bind_rows(TRSKeywordMatching)
  # ),
  #
  # tar_target(
  #   jecfa_tm_full,
  #   jecfa_augmented |>
  #     dplyr::left_join(
  #       keywordMatching,
  #       relationship = "many-to-many"
  #     ) |>
  #     dplyr::distinct()
  # ),
  #
  # # tables tm -------------------
  # tar_target(
  #   tbl5,
  #   compose_tbl5(keywordMatching)
  # ),
  #
  # tar_target(
  #   tbl6,
  #   compose_tbl6(keywordMatching)
  # ),
  #
  # tar_target(
  #   tbl7,
  #   compose_tbl7(keywordMatching)
  # ),
  #
  # tar_target(
  #   tbl8,
  #   compose_tbl8(jecfa_tm_full)
  # ),
  #
  # tar_target(
  #   tbl9,
  #   compose_tbl9(jecfa_tm_full)
  # ),
  #
  # tar_target(
  #   tbl10,
  #   compose_tbl10(jecfa_tm_full)
  # ),
  #
  #
  # tar_target(
  #   jecfaDistiller,
  #   create_distiller_jecfa(jecfa_tm_full)
  # ),
  #
  # tar_target(
  #   fileUsed,
  #   get_file_used(
  #     jecfaDistiller, fasPaths, trsUnique
  #   )
  # ),
  #
  # tar_target(
  #   moveUsed,
  #   move_file_used(
  #     fileUsed,
  #     here::here("data/used")
  #   ),
  #   format = "file"
  # ),
  #
  # # Report ----------------------
  # tar_render(
  #   jecfa_ws,
  #   here("report/jecfa_ws.Rmd")
  # ),
  # tar_render(
  #   pdf_tm_2,
  #   here("report/pdf_tm_2.Rmd")
  # ),
  #
  # # Share -----------------------
  # tar_target(
  #   objectToShare,
  #   list(
  #     jecfa_raw = jecfa_raw,
  #     jecfa = jecfa,
  #     jecfa_distiller = jecfaDistiller
  #   )
  # ),
  # tar_target(
  #   shareOutputNow,
  #   share_objects(
  #     objectToShare,
  #     last = FALSE
  #   ),
  #   format = "file",
  #   pattern = map(objectToShare)
  # ),
  # tar_target(
  #   shareOutput,
  #   share_objects(objectToShare),
  #   format = "file",
  #   pattern = map(objectToShare)
  # )
)
