defmodule Duper.PathFinder do
  use GenServer

  @me __MODULE__

  # API
  def start_link(root) do
    GenServer.start_link(@me, root, name: @me)
  end

  def next_path() do
    GenServer.call(@me, :next_path)
  end

  # Server
  def init(path) do
    DirWalker.start_link(path)
  end

  def handle_call(:next_path, _from, dir_walker) do
    path =
      case DirWalker.next(dir_walker) do
        [path] -> path
        other -> other
      end

    {:reply, path, dir_walker}
  end
end
