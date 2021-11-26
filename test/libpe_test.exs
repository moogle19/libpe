defmodule LibPETest do
  use ExUnit.Case
  doctest LibPE

  test "test open file" do
    for filename <- ["test/dialyzer.exe", "test/mt.exe"] do
      raw = File.read!(filename)
      {:ok, pe} = LibPE.parse_string(raw)

      assert raw == LibPE.encode(pe)
      assert pe.coff_header.checksum == LibPE.update_checksum(pe).coff_header.checksum
    end
  end

  test "test update file" do
    for filename <- ["test/dialyzer.exe", "test/mt.exe"] do
      raw = File.read!(filename)
      {:ok, pe} = LibPE.parse_string(raw)

      assert pe == LibPE.update_layout(pe)
    end
  end
end
