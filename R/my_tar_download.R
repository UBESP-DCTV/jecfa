my_tar_download <- function(
    name,
    urls,
    paths,
    method = NULL,
    quiet = TRUE,
    mode = "w",
    cacheOK = TRUE,
    extra = NULL,
    headers = NULL,
    iteration = targets::tar_option_get("iteration"),
    error = targets::tar_option_get("error"),
    memory = targets::tar_option_get("memory"),
    garbage_collection = targets::tar_option_get("garbage_collection"),
    deployment = targets::tar_option_get("deployment"),
    priority = targets::tar_option_get("priority"),
    resources = targets::tar_option_get("resources"),
    storage = targets::tar_option_get("storage"),
    retrieval = targets::tar_option_get("retrieval"),
    cue = targets::tar_option_get("cue")
) {
  name <- targets::tar_deparse_language(substitute(name))
  name_url <- paste0(name, "_url")
  # targets::tar_assert_chr(urls, "urls must be a character vector.")
  # targets::tar_assert_chr(paths, "paths must be a character vector.")
  # targets::tar_assert_nonempty(urls, "urls must be nonempty")
  # targets::tar_assert_nonempty(paths, "paths must be nonempty.")
  # targets::tar_assert_nzchar(urls, "urls must all be nonempty.")
  # targets::tar_assert_nzchar(paths, "paths must all be nonempty.")
  # if (length(urls) != length(paths)) {
  #   targets::tar_throw_validate(
  #     "'urls' has length ",
  #     length(urls),
  #     " but 'paths' has length ",
  #     length(paths),
  #     "."
  #   )
  # }
  command_url <- substitute(as.character(x), env = list(x = urls))
  command <- substitute(
    tarchetypes::tar_download_run(
      urls = x,
      paths = paths,
      method = method,
      quiet = quiet,
      mode = mode,
      cacheOK = cacheOK,
      extra = extra,
      headers = headers
    ),
    env = list(
      x = as.symbol(name_url),
      paths = paths,
      method = method,
      quiet = quiet,
      mode = mode,
      cacheOK = cacheOK,
      extra = extra,
      headers = headers
    )
  )
  target_url <- targets::tar_target_raw(
    name = name_url,
    command = command_url,
    format = "url",
    repository = "local",
    iteration = iteration,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    resources = resources,
    storage = storage,
    retrieval = retrieval,
    cue = cue
  )
  target_download <- targets::tar_target_raw(
    name = name,
    command = command,
    format = "file",
    repository = "local",
    iteration = iteration,
    error = error,
    memory = memory,
    garbage_collection = garbage_collection,
    deployment = deployment,
    priority = priority,
    resources = resources,
    storage = storage,
    retrieval = retrieval,
    cue = cue
  )
  list(target_url, target_download)
}
