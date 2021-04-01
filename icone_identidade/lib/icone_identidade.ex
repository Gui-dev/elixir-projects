defmodule IconeIdentidade do
  @moduledoc """
  Documentation for `IconeIdentidade`.
  """

  def main(input) do
    input
    |> hash_input
    |> criar_cor
    |> criar_tabela
    |> remover_impar
    |> constroi_pixel
  end

  def criar_cor(imagem) do
    %IconeIdentidade.Imagem{hex: [r, g, b | _tail]} = imagem
    %IconeIdentidade.Imagem{imagem | color: {r, g, b}}
  end

  def constroi_pixel(imagem) do
    %IconeIdentidade.Imagem{grid: grid} = imagem
    pixel_map = Enum.map grid, fn{ _valor, indice } ->
      horizontal = rem(indice, 5) * 50
      vertical = div(indice, 5) * 50
      topo_esquerdo = { horizontal, vertical }
      inferior_direita = { horizontal + 50, vertical + 50 }
      { topo_esquerdo, inferior_direita }
    end

    %IconeIdentidade.Imagem{ imagem | pixel_map: pixel_map }
  end

  def criar_tabela(imagem) do
    %IconeIdentidade.Imagem{hex: hex} = imagem
    grid = hex
    |> Enum.chunk(3)
    |> Enum.map(&espelhar/1)
    |> List.flatten
    |> Enum.with_index

    %IconeIdentidade.Imagem{imagem | grid: grid}
  end

  def remover_impar(imagem) do
    %IconeIdentidade.Imagem{grid: grid} = imagem
    new_grid = Enum.filter grid, fn { valor, _indice } ->
      rem(valor, 2) == 0
    end

    %IconeIdentidade.Imagem{ imagem | grid: new_grid }
  end

  def espelhar(linha) do
    [primeiro, segundo | _tail] = linha
    linha ++ [segundo, primeiro]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %IconeIdentidade.Imagem{hex: hex}
  end
end
