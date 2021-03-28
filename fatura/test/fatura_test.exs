defmodule FaturaTest do
  use ExUnit.Case
  doctest Fatura

  test 'deve criar uma lista de faturas' do
    faturas = Fatura.criar_fatura(['Telefone', 'Agua', 'Luz'])
    assert faturas == ['Telefone', 'Agua', 'Luz']
  end

  test 'devem ordenar uma lista de faturas' do
    faturas = Fatura.criar_fatura(['Telefone', 'Agua', 'Luz'])
    refute Fatura.ordena_fatura(faturas) == ['Telefone', 'Agua', 'Luz']
  end

  test 'deve verificar se a conta existe' do
    assert Fatura.fatura_existe?(Fatura.criar_fatura(['Telefone', 'Agua', 'Luz']), 'Luz') == true
  end
end
