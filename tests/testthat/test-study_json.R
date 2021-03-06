context("test-study_json")

test_that("defaults", {
  j <- study() %>% study_json()

  comp <- '{
    "name": "Demo Study",
    "info": [],
    "hypotheses": [],
    "methods": [],
    "data": [],
    "prep": [],
    "analyses": []
}
'
  class(comp) <- "json"

  testthat::expect_equal(j, comp)
})

test_that("extra study args", {
  j <- study("Name", description = "My study") %>% study_json()
  comp <- '{
    "name": "Name",
    "info": {
        "description": "My study"
    },
    "hypotheses": [],
    "methods": [],
    "data": [],
    "prep": [],
    "analyses": []
}
'
  class(comp) <- "json"

  testthat::expect_equal(j, comp)
})

test_that("numeric arrays", {
  dat <- data.frame(x = 1:5)
  j <- study() %>% add_data(dat) %>% study_json()
  match <- grep('"values": [1, 2, 3, 4, 5]', j, fixed = TRUE)
  expect_equal(match, 1)
})
