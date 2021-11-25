defmodule LibPE.SectionFlags do
  use Bitwise

  def flags() do
    [
      {"", 0, "Reserved for future use."},
      {"", 1, "Reserved for future use."},
      {"", 2, "Reserved for future use."},
      {"", 4, "Reserved for future use."},
      {"IMAGE_SCN_TYPE_NO_PAD", 8,
       "The section should not be padded to the next boundary. This flag is obsolete and is replaced by IMAGE_SCN_ALIGN_1BYTES. This is valid only for object files."},
      {"", 16, "Reserved for future use."},
      {"IMAGE_SCN_CNT_CODE", 32, "The section contains executable code."},
      {"IMAGE_SCN_CNT_INITIALIZED_DATA", 64, "The section contains initialized data."},
      {"IMAGE_SCN_CNT_UNINITIALIZED_ DATA", 128, "The section contains uninitialized data."},
      {"IMAGE_SCN_LNK_OTHER", 256, "Reserved for future use."},
      {"IMAGE_SCN_LNK_INFO", 512,
       "The section contains comments or other information. The .drectve section has this type. This is valid for object files only."},
      {"", 1024, "Reserved for future use."},
      {"IMAGE_SCN_LNK_REMOVE", 2048,
       "The section will not become part of the image. This is valid only for object files."},
      {"IMAGE_SCN_LNK_COMDAT", 4096,
       "The section contains COMDAT data. For more information, see COMDAT Sections (Object Only). This is valid only for object files."},
      {"IMAGE_SCN_GPREL", 32768,
       "The section contains data referenced through the global pointer (GP)."},
      {"IMAGE_SCN_MEM_PURGEABLE", 131_072, "Reserved for future use."},
      {"IMAGE_SCN_MEM_16BIT", 131_072, "Reserved for future use."},
      {"IMAGE_SCN_MEM_LOCKED", 262_144, "Reserved for future use."},
      {"IMAGE_SCN_MEM_PRELOAD", 524_288, "Reserved for future use."},
      {"IMAGE_SCN_ALIGN_1BYTES", 1_048_576,
       "Align data on a 1-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_2BYTES", 2_097_152,
       "Align data on a 2-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_4BYTES", 3_145_728,
       "Align data on a 4-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_8BYTES", 4_194_304,
       "Align data on an 8-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_16BYTES", 5_242_880,
       "Align data on a 16-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_32BYTES", 6_291_456,
       "Align data on a 32-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_64BYTES", 7_340_032,
       "Align data on a 64-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_128BYTES", 8_388_608,
       "Align data on a 128-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_256BYTES", 9_437_184,
       "Align data on a 256-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_512BYTES", 10_485_760,
       "Align data on a 512-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_1024BYTES", 11_534_336,
       "Align data on a 1024-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_2048BYTES", 12_582_912,
       "Align data on a 2048-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_4096BYTES", 13_631_488,
       "Align data on a 4096-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_ALIGN_8192BYTES", 14_680_064,
       "Align data on an 8192-byte boundary. Valid only for object files."},
      {"IMAGE_SCN_LNK_NRELOC_OVFL", 16_777_216, "The section contains extended relocations."},
      {"IMAGE_SCN_MEM_DISCARDABLE", 33_554_432, "The section can be discarded as needed."},
      {"IMAGE_SCN_MEM_NOT_CACHED", 67_108_864, "The section cannot be cached."},
      {"IMAGE_SCN_MEM_NOT_PAGED", 134_217_728, "The section is not pageable."},
      {"IMAGE_SCN_MEM_SHARED", 268_435_456, "The section can be shared in memory."},
      {"IMAGE_SCN_MEM_EXECUTE", 536_870_912, "The section can be executed as code."},
      {"IMAGE_SCN_MEM_READ", 1_073_741_824, "The section can be read."},
      {"IMAGE_SCN_MEM_WRITE", 2_147_483_648, "The section can be written to. "}
    ]
  end

  def decode(numeric_flags) do
    Enum.reduce(flags(), [], fn char, acc ->
      {_, id, _} = char

      if (numeric_flags &&& id) == 0 do
        acc
      else
        acc ++ [char]
      end
    end)
  end

  def encode(numeric_flag) when is_integer(numeric_flag), do: numeric_flag

  def encode(flags) when is_list(flags) do
    Enum.reduce(flags, 0, fn flag, ret ->
      num =
        case flag do
          num when is_integer(flag) ->
            num

          {_, num, _} ->
            num

          name when is_binary(name) ->
            {_, num, _} = Enum.find(flags(), fn {ename, _, _} -> name == ename end)
            num
        end

      ret ||| num
    end)
  end
end
