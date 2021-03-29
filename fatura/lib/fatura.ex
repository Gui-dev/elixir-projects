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
    Ao receber `faturas` e `quantidades` retorna a quantidade de fatura á ser pagas
      ## Exemplos
      iex> Fatura.faturas_a_pagar(Fatura.criar_faturas(['Telefone', 'Agua'], [5, 10]), 1)
      {
        [
          'Fatura: Telefone vence no dia: 5'
        ],
        [
          'Fatura: Agua vence no dia: 5',
          'Fatura: Telefone vence no dia: 10',
          'Fatura: Agua vence no dia: 10'
        ]
      }
  """
  def faturas_a_pagar(faturas, quantidades) do
    Enum.split(faturas, quantidades)
  end

  def save(nome_arquivo, faturas) do
    binary = :erlang.term_to_binary(faturas)
    File.write!(nome_arquivo, binary)
  end

  def load(nome_arquivo) do
    { status, file } = File.read(nome_arquivo)

    case status do
      :ok -> :erlang.binary_to_term file
      :error -> "Não foi possível carregar o arquivo"
    end

  end

  def pagar_uma_fatura(faturas, vencimento, quantidade) do
    criar_faturas(faturas, vencimento)
    |> ordena_fatura
    |> faturas_a_pagar(quantidade)
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
