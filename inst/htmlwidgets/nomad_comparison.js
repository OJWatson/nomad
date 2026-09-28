HTMLWidgets.widget({
  name: 'nomad_comparison', type: 'output',
  factory: function(el) {
    return {renderValue: function(x) {
      el.replaceChildren();
      el.style.overflow = 'auto';
      function add(tag, text, parent) {
        var node = document.createElement(tag);
        if (text !== undefined) node.textContent = text;
        (parent || el).appendChild(node);
        return node;
      }
      add('p', 'A: ' + x.label_a + ' · B: ' + x.label_b);
      var label = add('label', 'Weight of model B: ');
      var slider = add('input', undefined, label);
      slider.type = 'range'; slider.min = 0; slider.max = 1; slider.step = 0.01;
      slider.value = x.weight;
      slider.setAttribute('aria-label', 'Weight of model B');
      var value = add('span', '', label);
      var summary = add('p'); summary.setAttribute('aria-live', 'polite');
      add('p', 'Showing up to 12 busiest origins and destinations. Totals use all regions. ' +
        'Values are predicted trips' + (x.period ? ' per ' + x.period + ' days.' : ' (period unknown).'));
      var table = add('table'); table.style.width = '100%';
      var header = add('tr', undefined, add('thead', undefined, table));
      ['Origin', 'Destination', 'A', 'B', 'Ensemble', 'Ensemble − A'].forEach(function(s) {
        var cell = add('th', s, header); cell.scope = 'col'; cell.style.textAlign = 'left';
      });
      var body = add('tbody', undefined, table), cells = [];
      function fmt(v) { return v.toLocaleString(undefined, {maximumFractionDigits: 1}); }
      x.rows.forEach(function(origin, i) {
        x.cols.forEach(function(dest, j) {
          var row = add('tr', undefined, body);
          [origin, dest, fmt(x.a[i][j]), fmt(x.b[i][j])].forEach(function(v) { add('td', v, row); });
          cells.push({a: x.a[i][j], b: x.b[i][j], mean: add('td', '', row), diff: add('td', '', row)});
        });
      });
      function update() {
        var w = Number(slider.value);
        value.textContent = ' ' + w.toFixed(2) + ' (A: ' + (1 - w).toFixed(2) + ')';
        summary.textContent = 'Total trips — A: ' + fmt(x.total_a) + '; B: ' + fmt(x.total_b) +
          '; ensemble: ' + fmt((1 - w) * x.total_a + w * x.total_b);
        cells.forEach(function(c) {
          var mean = (1 - w) * c.a + w * c.b;
          c.mean.textContent = fmt(mean); c.diff.textContent = fmt(mean - c.a);
        });
      }
      slider.addEventListener('input', update); update();
    }, resize: function() {}};
  }
});
