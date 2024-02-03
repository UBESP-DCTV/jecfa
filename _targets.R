library(targets)
library(tarchetypes)
library(here)

tar_option_set(
  packages = c("tibble"),
  format = "qs",
  error = "continue"
)

tar_source()

# Targets ---------------------
list(
  tar_target(
    name = jecfa_ids,
    command = seq_len(30)
  ),

  tar_target(
    name = jecfa_list,
    command = compose_jecfa_list(jecfa_ids),
    pattern = map(jecfa_ids),
    iteration = "list"
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
  ),

  # Tables ----------------------
  tar_target(
    name = tbl1,
    command = compose_tbl1(jecfa_augmented)
  ),
  tar_target(
    name = tbl2,
    command = compose_tbl2(jecfa_augmented)
  ),
  tar_target(
    name = tbl3,
    command = compose_tbl3(jecfa_augmented)
  ),
  tar_target(
    name = tbl4,
    command = compose_tbl4(jecfa_augmented)
  ),


  # TRS -------------------------
  tar_target(
    urls_list,
    command = compose_urls(jecfa_augmented)
  ),

  tar_target(
    urls_ok,
    command = remove_null_urls(urls_list)
  ),

  tar_target(
    trsPaths,
    compose_filepaths(
      urls_ok, here::here("data/TRS")
    )
  ),

  tar_target(
    trsUrls,
    command = purrr::map_chr(urls_ok, "url"),
    format = "url",
    resources = tar_resources(
      url = tar_resources_url(
        handle = curl::new_handle(
          nobody = TRUE
        )
      )
    )
  ),

  tar_target(
    trsDownload,
    download_trs(trsUrls, trsPaths),
    pattern = map(trsUrls, trsPaths),
    format = "file"
  ),

  # tar_download(
  #   trs,
  #   urls = url_iter,
  #   paths =
  # ),


  # Report ----------------------
  tar_render(
    jecfa_ws,
    here("report/jecfa_ws.Rmd")
  ),

  # Share -----------------------
  tar_target(
    objectToShare,
    list(
      jecfa_raw = jecfa_raw,
      jecfa = jecfa
    )
  ),
  tar_target(
    shareOutputNow,
    share_objects(
      objectToShare,
      last = FALSE
    ),
    format = "file",
    pattern = map(objectToShare)
  ),
  tar_target(
    shareOutput,
    share_objects(objectToShare),
    format = "file",
    pattern = map(objectToShare)
  )
)
