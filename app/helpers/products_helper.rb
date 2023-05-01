module ProductsHelper

  def simple_description(description)
    description.truncate(10)
  end

  def date_format(date)
    meses = %w[Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre]
    mes = meses[date.month - 1]
    dia = date.strftime('%d')
    year = date.strftime('%Y')

    "#{dia} de #{mes} del #{year}"
  end

end
