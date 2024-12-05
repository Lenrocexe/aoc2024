use "collections"
use "iterTools"
use "files"

actor Main
  new create(env: Env) =>

    // Let's start with the sample input
    trySample(env)

    // Now solve the real puzzle
    solvePuzzle(env)

  fun trySample(env: Env) =>
    try
      // The total distance is the answer to the puzzle
      var distance: I32 = 0

      // Create sorted arrays of based on the examples
      let list1: Array[I32] = Sort[Array[I32], I32]([3; 4; 2; 1; 3; 3])
      let list2: Array[I32] = Sort[Array[I32], I32]([4; 3; 5; 3; 9; 3])

      // Create iterator that combines the two lists using zip
      var result = Iter[I32](list1.values()).zip[I32](list2.values())

      // Iterate over the results and calculate the distance between each tuple's elements
      while result.has_next() do
        var item = result.next()?
        distance = distance + (item._1 - item._2).abs().i32()

        env.out.print(item._1.string() + " - " + item._2.string() + " = " + (item._1 - item._2).abs().string())
      end

      env.out.print("Total distance: " + distance.string())
    end

  fun solvePuzzle(env: Env) =>
      // The total distance is the answer to the puzzle
    var distance: I32 = 0

    var fileList1: Array[I32] = Array[I32]()
    var fileList2: Array[I32] = Array[I32]()

    try
      let file_name = "input.txt"
      let path = FilePath(FileAuth(env.root), file_name)

      // Read the file and save each value in the appropriate list
      match OpenFile(path)
      | let file: File =>
        let fileLines = FileLines(file)

        while fileLines.has_next() do
          let line = fileLines.next()?
          let location = line.split(" ")

          // I don't know how to properly split each row so that we only
          // have 2 values. location{1) and location(2) contain just empty strings.
          fileList1.push(location(0)?.i32()?)
          fileList2.push(location(3)?.i32()?)
        end

        env.out.print("For some reason an error is thrown once the while loop is done")
        env.out.print("The only wat to continue for now is to parse the file in the try's else block")
        env.out.print("The else block is basically the catch block in other languages")
        env.out.print("But the error/exception is not forwarded to the catch block")
      // The "catch" block for when the file can't be opened
      else
        env.err.print("Error opening file '" + file_name + "'")
      end

    // The catch block of the try
    else
      try
          let sorted1 = Sort[Array[I32], I32](fileList1)
          let sorted2 = Sort[Array[I32], I32](fileList2)
          var sortIter = Iter[I32](sorted1.values()).zip[I32](sorted2.values())

          while sortIter.has_next() do
            var item = sortIter.next()?
            distance = distance + (item._1 - item._2).abs().i32()

            env.out.print(item._1.string() + " " + item._2.string() + " " + (item._1 - item._2).abs().string())
          end

          env.out.print("Total distance: " + distance.string())
      end

    end
