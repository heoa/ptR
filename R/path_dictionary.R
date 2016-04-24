#' @title Path dictionary
#'
#' @description Calculate path dictionary for a process tree
#'
#' @export path_dictionary


path_dictionary <- function(tree, n_iterations_loop){
	if(is.null(tree$children)){
		if(tree$name == "tau")
			return(data.frame( length = 0,n = 1))
		else
			return(data.frame(length = 1,n = 1))
	}
	else {
		children <- list()
		for(i in 1:length(tree$children)){
			children[[i]] <- Recall(tree$children[[i]], n_iterations_loop = n_iterations_loop)
		}

		if(tree$name == "sequence"){
			sequence_node(children) %>% return
		}
		else if(tree$name == "choice"){
			choice_node(children) %>% return
		}
		else if(tree$name == "parallel"){
			parallel_node(children) %>% return
		}
		else if(tree$name == "loop") {
			loop_node(children, n_iterations_loop = n_iterations_loop) %>% return
		}
		else if(tree$name == "or"){
			or_node(children) %>% return
		}
	}
}