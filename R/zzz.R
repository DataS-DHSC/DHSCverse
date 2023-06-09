core <- c(
  "DHSCtools", "DHSCcolours", "DHSClogger", "readfoundry"
)

core_unloaded <- function() {
  search <- paste0("package:", core)
  return(core[!search %in% search()])
}

# Attach the package from the same package library it was
# loaded from before.
same_library <- function(pkg) {
  loc <- if (pkg %in% loadedNamespaces()) dirname(getNamespaceInfo(pkg, "path"))
  library(pkg, lib.loc = loc, character.only = TRUE, warn.conflicts = FALSE)
}

verse_attach <- function() {
  to_load <- core_unloaded()

  suppressPackageStartupMessages(
    lapply(to_load, same_library)
  )

  return(invisible(to_load))
}

.onAttach <- function(...) {
  attached <- verse_attach()
}
