function dataFiltered = myPreFilter(data, a_pe)

    n = 2 : length(data);
    dataFiltered(1) = data(1);
    dataFiltered(n) = data(n) - a_pe * data(n - 1);

end

