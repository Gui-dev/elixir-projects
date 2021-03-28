defmodule Fatura do
  @moduledoc """
    Este módulo executamos funções de fatura
  """

  @doc """
    Ao receber `faturas` retorna um array de faturas
      ## Exemplos
      iex> Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10])
      ['Telefone', 'Agua']
  """
  def criar_faturas(faturas, vencimentos) do
    for vencimento <- vencimentos, fatura <- faturas do
      'Fatura: #{fatura} vence no dia: #{vencimento}'
    end
  end

  @doc """
    Ao receber `fatura` retorna um array de faturas ordenado
      ##Exemplos
      iex> Fatura.ordena_fatura(Fatura.criar_fatura(['Telefone', 'Agua']))
      ['Agua', 'Telefone']
  """
  def ordena_fatura(faturas) do
    Enum.sort(faturas)
  end

  @doc """
    Ao receber `faturas` e um elemento de `fatura` retorna se ele existe ou não
      ## Exemplos
      iex> Fatura.fatura_existe?(Fatura.criar_fatura(['Telefone', 'Agua']), 'Luz')
  """
  def fatura_existe?(faturas, fatura) do
    Enum.member?(faturas, fatura)
  end
end